class HomeController < ApplicationController
  def index
    customization = Customization.all.first
    @page_title = customization.short_title
    @title, @subtitle = customization.book_title.split(/:\s*/)
  end
end
