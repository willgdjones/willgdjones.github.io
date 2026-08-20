#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "obsidian_essay_sync"

include ObsidianEssaySync

source_path = OBSIDIAN_VAULT_DIR.join("Homepage.md")
website_path = REPO_ROOT.join("index.md")
manifest = read_manifest
manifest["homepage"] ||= {}
dry_run = dry_run?

abort "Missing homepage source: #{source_path}" unless source_path.exist?

raw_note = source_path.read
metadata, body = split_front_matter(raw_note)
abort "Homepage must declare publish: true" unless metadata["publish"] == true

previous = manifest["homepage"]
current_output = website_path.exist? ? website_path.read : ""
source_changed = previous["source_hash"] && previous["source_hash"] != sha256(raw_note)
output_changed = previous["output_hash"] && previous["output_hash"] != sha256(current_output)
abort "Homepage conflict: both Obsidian and website copies changed" if source_changed && output_changed

website_content = <<~CONTENT
  ---
  layout: home
  title: Home
  ---

  #{GENERATED_WARNING}

  #{body.rstrip}
CONTENT

write_file(website_path, website_content, dry_run: dry_run)
manifest["homepage"] = {
  "obsidian_path" => source_path.to_s.sub("#{OBSIDIAN_VAULT_DIR}/", ""),
  "website_path" => website_path.relative_path_from(REPO_ROOT).to_s,
  "source_hash" => sha256(raw_note),
  "output_hash" => sha256(website_content)
}
write_manifest(manifest, dry_run: dry_run)

puts "Homepage sync complete#{' (dry run)' if dry_run}"
