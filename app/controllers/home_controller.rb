class HomeController < ApplicationController
  def index
    customization = Customization.all.first
    @page_title = customization.short_title
    @title, @subtitle = customization.book_title.split(/:\s*/)

    path = customization.book_root_file_path
    @book_file_name = File.basename(path, ".xml")
  end
end
