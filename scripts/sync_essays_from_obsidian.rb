#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "obsidian_essay_sync"

include ObsidianEssaySync

dry_run = ObsidianEssaySync.dry_run?
manifest = ObsidianEssaySync.read_manifest
manifest["essays"] ||= {}

synced = 0
skipped = 0
conflicts = []
missing_images = {}

ObsidianEssaySync.markdown_files(ObsidianEssaySync::OBSIDIAN_ESSAYS_DIR).each do |note_path|
  raw_note = note_path.read
  metadata, body = ObsidianEssaySync.split_front_matter(raw_note)

  unless metadata["publish"] == true && metadata["collection"].to_s == "essays"
    skipped += 1
    next
  end

  slug = metadata.fetch("slug")
  website_path = ObsidianEssaySync::WEBSITE_ESSAYS_DIR.join("#{slug}.md")
  previous = manifest["essays"][slug] || {}
  current_output = website_path.exist? ? website_path.read : ""

  source_changed = previous["source_hash"] && previous["source_hash"] != ObsidianEssaySync.sha256(raw_note)
  output_changed = previous["output_hash"] && previous["output_hash"] != ObsidianEssaySync.sha256(current_output)

  if source_changed && output_changed
    conflicts << slug
    next
  end

  website_body, missing = ObsidianEssaySync.sync_images_to_website(body, slug, dry_run: dry_run)
  missing_images[slug] = missing unless missing.empty?

  website_metadata = {
    "layout" => "post",
    "title" => metadata["title"],
    "date" => metadata["date"],
    "description" => metadata["description"]
  }
  website_metadata["draft"] = metadata["draft"] if metadata.key?("draft")

  website_content = ObsidianEssaySync.build_front_matter(website_metadata) +
                    "#{ObsidianEssaySync::GENERATED_WARNING}\n\n" +
                    website_body.rstrip +
                    "\n"

  ObsidianEssaySync.write_file(website_path, website_content, dry_run: dry_run)

  manifest["essays"][slug] = {
    "obsidian_path" => note_path.to_s.sub("#{ObsidianEssaySync::OBSIDIAN_VAULT_DIR}/", ""),
    "website_path" => website_path.relative_path_from(ObsidianEssaySync::REPO_ROOT).to_s,
    "source_hash" => ObsidianEssaySync.sha256(raw_note),
    "output_hash" => ObsidianEssaySync.sha256(website_content)
  }
  synced += 1
end

if conflicts.any?
  warn "Conflicts detected; no manifest written for conflicted sync:"
  conflicts.each { |slug| warn "  #{slug}" }
  exit 1
end

ObsidianEssaySync.write_manifest(manifest, dry_run: dry_run)

puts "Sync complete#{' (dry run)' if dry_run}: #{synced} synced, #{skipped} skipped"
if missing_images.empty?
  puts "No missing images"
else
  puts "Missing images:"
  missing_images.each { |slug, images| puts "  #{slug}: #{images.join(', ')}" }
end
