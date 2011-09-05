NONBREAKING_SPACE = "\xC2\xA0"

class HomeController < ApplicationController
  def index
    customization = Customization.all.first
    @page_title = customization.short_title
    @title, @subtitle = customization.book_title.split(/:\s*/)

    path = customization.book_root_file_path
    @book_file_name = File.basename(path, ".xml")

    @toc_entry_hashes = []
    ContentUpdate.where('successful = 1').last.toc_entries.each do |entry|
      text_sections = entry.entry_text.split(NONBREAKING_SPACE)
      number = text_sections.length == 1 ? nil :
          text_sections[0..-2].join(' ')
      @toc_entry_hashes << {
          :number => number,
          :text => text_sections.last,
          :level => entry.indent_level
      }
    end
  end
end
