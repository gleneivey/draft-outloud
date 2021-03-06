NONBREAKING_SPACE = "\xC2\xA0"

class HomeController < ApplicationController
  def index
    customization = Customization.all.first
    @page_title = customization.short_title
    @title, @subtitle = customization.book_title.split(/:\s*/)

    path = customization.book_root_file_path
    @book_file_name = File.basename(path, ".xml")

    @toc_entry_hashes = []
    toc_entries = []
    content_update = ContentUpdate.where('successful = 1').last
    if content_update && (toc_entries = content_update.toc_entries)
      toc_entries.each do |entry|
        text_sections = entry.entry_text.split(NONBREAKING_SPACE)
        number = text_sections.length == 1 ? nil :
            text_sections[0..-2].join(' ')
        @toc_entry_hashes << {
            :number => number,
            :text => text_sections.last,
            :level => entry.indent_level,
            :id => entry.html_anchor
        }
      end
    end
  end
end
