#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "obsidian_essay_sync"

include ObsidianEssaySync

dry_run = ObsidianEssaySync.dry_run?
manifest = ObsidianEssaySync.read_manifest
manifest["essays"] ||= {}

created = 0
merged = 0
missing_images = {}

ObsidianEssaySync.markdown_files(ObsidianEssaySync::WEBSITE_ESSAYS_DIR).each do |essay_path|
  raw = essay_path.read
  metadata, body = ObsidianEssaySync.split_front_matter(raw)

  title = metadata.fetch("title", ObsidianEssaySync.slug_for(essay_path))
  slug = ObsidianEssaySync.slug_for(essay_path)
  existing_note = ObsidianEssaySync.find_existing_note(title, slug)
  note_path = if existing_note
                ObsidianEssaySync::OBSIDIAN_ESSAYS_DIR.join(existing_note.basename.to_s)
              else
                ObsidianEssaySync::OBSIDIAN_ESSAYS_DIR.join(ObsidianEssaySync.note_filename(title))
              end

  imported_body, missing = ObsidianEssaySync.import_images_to_obsidian(body, slug, dry_run: dry_run)
  missing_images[slug] = missing unless missing.empty?

  if existing_note&.exist?
    existing_metadata, existing_body = ObsidianEssaySync.split_front_matter(existing_note.read)
    note_metadata = existing_metadata.merge(
      "title" => title,
      "date" => metadata["date"],
      "description" => metadata["description"],
      "publish" => true,
      "collection" => "essays",
      "slug" => slug,
      "website_source_path" => essay_path.relative_path_from(ObsidianEssaySync::REPO_ROOT).to_s
    )
    note_metadata["draft"] = metadata["draft"] if metadata.key?("draft")
    note_body = existing_body.strip.empty? ? imported_body : imported_body
    merged += 1
  else
    note_metadata = {
      "title" => title,
      "date" => metadata["date"],
      "description" => metadata["description"],
      "publish" => true,
      "collection" => "essays",
      "slug" => slug,
      "website_source_path" => essay_path.relative_path_from(ObsidianEssaySync::REPO_ROOT).to_s
    }
    note_metadata["draft"] = metadata["draft"] if metadata.key?("draft")
    note_body = imported_body
    created += 1
  end

  note_content = ObsidianEssaySync.build_front_matter(note_metadata) + note_body.rstrip + "\n"
  ObsidianEssaySync.write_file(note_path, note_content, dry_run: dry_run)
  if existing_note && existing_note != note_path
    ObsidianEssaySync.delete_file(existing_note, dry_run: dry_run)
  end

  output_hash = ObsidianEssaySync.sha256(raw)
  source_hash = ObsidianEssaySync.sha256(note_content)
  manifest["essays"][slug] = {
    "obsidian_path" => note_path.to_s.sub("#{ObsidianEssaySync::OBSIDIAN_VAULT_DIR}/", ""),
    "website_path" => essay_path.relative_path_from(ObsidianEssaySync::REPO_ROOT).to_s,
    "source_hash" => source_hash,
    "output_hash" => output_hash
  }
end

ObsidianEssaySync.write_manifest(manifest, dry_run: dry_run)

puts "Import complete#{' (dry run)' if dry_run}: #{created} to create, #{merged} to merge"
if missing_images.empty?
  puts "No missing images"
else
  puts "Missing images:"
  missing_images.each { |slug, images| puts "  #{slug}: #{images.join(', ')}" }
end
