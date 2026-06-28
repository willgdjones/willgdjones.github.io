# frozen_string_literal: true

require "date"
require "digest"
require "fileutils"
require "pathname"
require "yaml"

module ObsidianEssaySync
  REPO_ROOT = Pathname.new(__dir__).parent.expand_path
  WEBSITE_ESSAYS_DIR = REPO_ROOT.join("_essays")
  WEBSITE_IMAGES_DIR = REPO_ROOT.join("assets/images")
  OBSIDIAN_VAULT_DIR = Pathname.new("/Users/willgdjones/Documents/Notes")
  OBSIDIAN_ESSAYS_DIR = OBSIDIAN_VAULT_DIR.join("Essays")
  OBSIDIAN_ASSETS_DIR = OBSIDIAN_ESSAYS_DIR.join("assets")
  MANIFEST_PATH = REPO_ROOT.join(".obsidian-essay-sync.yml")
  GENERATED_WARNING = "<!-- Generated from Obsidian. Edit the source note instead. -->"

  module_function

  def dry_run?
    ARGV.include?("--dry-run")
  end

  def markdown_files(dir)
    Dir.glob(dir.join("*.md")).sort.map { |path| Pathname.new(path) }
  end

  def split_front_matter(text)
    return [{}, text] unless text.start_with?("---\n")

    parts = text.split(/^---\s*$\n?/, 3)
    return [{}, text] unless parts.length == 3 && parts[0].empty?

    metadata = YAML.safe_load(
      parts[1],
      permitted_classes: [Date, Time],
      aliases: true
    ) || {}
    [stringify_keys(metadata), parts[2].sub(/\A\n+/, "")]
  end

  def build_front_matter(metadata)
    ordered = metadata.each_with_object({}) { |(key, value), memo| memo[key.to_s] = normalize_yaml_value(value) }
    "#{ordered.to_yaml}---\n\n"
  end

  def normalize_yaml_value(value)
    case value
    when Date, Time
      value.strftime("%Y-%m-%d")
    else
      value
    end
  end

  def stringify_keys(hash)
    hash.each_with_object({}) { |(key, value), memo| memo[key.to_s] = value }
  end

  def normalize_title(title)
    title.to_s.downcase.gsub(/[^a-z0-9]+/, " ").strip
  end

  def note_filename(title)
    safe = title.to_s.strip.gsub(/[\/:]/, "-").gsub(/\s+/, " ")
    safe = safe.sub(/[.]+\z/, "")
    safe = "Untitled" if safe.empty?
    "#{safe}.md"
  end

  def slug_for(path)
    path.basename(".md").to_s
  end

  def sha256(text)
    Digest::SHA256.hexdigest(text)
  end

  def read_manifest
    return {} unless MANIFEST_PATH.exist?

    YAML.safe_load(MANIFEST_PATH.read, aliases: true) || {}
  end

  def write_manifest(manifest, dry_run: false)
    if dry_run
      puts "Would write manifest #{MANIFEST_PATH}"
      return
    end

    MANIFEST_PATH.write("#{manifest.to_yaml}---\n")
  end

  def write_file(path, content, dry_run: false)
    if dry_run
      puts "Would write #{path}"
      return
    end

    FileUtils.mkdir_p(path.dirname)
    path.write(content)
  end

  def copy_file(source, destination, dry_run: false)
    if dry_run
      puts "Would copy #{source} -> #{destination}"
      return
    end

    FileUtils.mkdir_p(destination.dirname)
    FileUtils.cp(source, destination)
  end

  def delete_file(path, dry_run: false)
    if dry_run
      puts "Would delete #{path}"
      return
    end

    path.delete if path.exist?
  end

  def website_image_path_for(src)
    return nil unless src.start_with?("/assets/images/")

    REPO_ROOT.join(src.sub(%r{\A/}, ""))
  end

  def obsidian_asset_rel(slug, source_path)
    "Essays/assets/#{slug}/#{File.basename(source_path)}"
  end

  def import_images_to_obsidian(body, slug, dry_run: false)
    missing = []

    rewritten = body.gsub(/!\[([^\]]*)\]\((\/assets\/images\/[^)]+)\)/) do
      alt = Regexp.last_match(1)
      src = Regexp.last_match(2)
      source = website_image_path_for(src)
      if source&.exist?
        destination = OBSIDIAN_ASSETS_DIR.join(slug, source.basename.to_s)
        copy_file(source, destination, dry_run: dry_run)
        suffix = alt.empty? ? "" : "|#{alt}"
        "![[#{obsidian_asset_rel(slug, source)}#{suffix}]]"
      else
        missing << src
        Regexp.last_match(0)
      end
    end

    rewritten = rewritten.gsub(/<img\b([^>]*?)\bsrc=["'](\/assets\/images\/[^"']+)["']([^>]*)>/i) do
      before = Regexp.last_match(1)
      src = Regexp.last_match(2)
      after = Regexp.last_match(3)
      attrs = "#{before} #{after}"
      alt = attrs[/\balt=["']([^"']*)["']/i, 1].to_s
      source = website_image_path_for(src)
      if source&.exist?
        destination = OBSIDIAN_ASSETS_DIR.join(slug, source.basename.to_s)
        copy_file(source, destination, dry_run: dry_run)
        suffix = alt.empty? ? "" : "|#{alt}"
        "![[#{obsidian_asset_rel(slug, source)}#{suffix}]]"
      else
        missing << src
        Regexp.last_match(0)
      end
    end

    [normalize_obsidian_image_blocks(rewritten), missing.uniq]
  end

  def normalize_obsidian_image_blocks(body)
    normalized = body.gsub(%r{<figure[^>]*>\s*(!\[\[(?:Published Essays/|Essays/)?assets/[^\]]+\]\])\s*<figcaption>(.*?)</figcaption>\s*</figure>}mi) do
      embed = Regexp.last_match(1)
      caption = Regexp.last_match(2).strip
      caption.empty? ? embed : "#{embed}\n\n*#{caption}*"
    end

    normalized = normalized.gsub(%r{<figure[^>]*>\s*(!\[\[(?:Published Essays/|Essays/)?assets/[^\]]+\]\])\s*</figure>}mi) do
      Regexp.last_match(1)
    end

    normalized = normalized.gsub(%r{<div[^>]*>\s*(!\[\[(?:Published Essays/|Essays/)?assets/[^\]]+\]\])\s*<p><em>(.*?)</em></p>\s*</div>}mi) do
      embed = Regexp.last_match(1)
      caption = Regexp.last_match(2).strip
      caption.empty? ? embed : "#{embed}\n\n*#{caption}*"
    end

    normalized.gsub(%r{<div style="display:\s*flex;[^>]*>\s*(.*?)\s*</div>}mi, "\\1")
  end

  def sync_images_to_website(body, slug, dry_run: false)
    missing = []

    rewritten = body.gsub(%r{<figure>\s*!\[\[(?:Published Essays/|Essays/)?assets/([^/\]]+)/([^\]|\n]+)(?:\|([^\]\n]+))?\]\]\s*(<figcaption>.*?</figcaption>)\s*</figure>}mi) do
      asset_slug = Regexp.last_match(1)
      filename = Regexp.last_match(2)
      alt = Regexp.last_match(3).to_s
      caption = Regexp.last_match(4)
      source = OBSIDIAN_ASSETS_DIR.join(asset_slug, filename)
      if source.exist?
        destination = WEBSITE_IMAGES_DIR.join("obsidian", slug, filename)
        copy_file(source, destination, dry_run: dry_run)
        "<figure>\n  <img src=\"/assets/images/obsidian/#{slug}/#{filename}\" alt=\"#{alt}\">\n  #{caption}\n</figure>"
      else
        missing << source.to_s
        Regexp.last_match(0)
      end
    end

    rewritten = rewritten.gsub(/!\[\[(?:Published Essays\/|Essays\/)?assets\/([^\/\]]+)\/([^\]|\n]+)(?:\|([^\]\n]+))?\]\]/) do
      asset_slug = Regexp.last_match(1)
      filename = Regexp.last_match(2)
      alt = Regexp.last_match(3).to_s
      source = OBSIDIAN_ASSETS_DIR.join(asset_slug, filename)
      if source.exist?
        destination = WEBSITE_IMAGES_DIR.join("obsidian", slug, filename)
        copy_file(source, destination, dry_run: dry_run)
        "![#{alt}](/assets/images/obsidian/#{slug}/#{filename})"
      else
        missing << source.to_s
        Regexp.last_match(0)
      end
    end

    [rewritten, missing.uniq]
  end

  def find_existing_note(title, slug)
    notes = markdown_files(OBSIDIAN_ESSAYS_DIR) + markdown_files(OBSIDIAN_VAULT_DIR)
    notes.uniq!

    by_title = notes.find { |path| normalize_title(path.basename(".md").to_s) == normalize_title(title) }
    return by_title if by_title

    notes.find do |path|
      metadata, = split_front_matter(path.read)
      metadata["slug"].to_s == slug
    rescue Psych::SyntaxError
      false
    end
  end
end
