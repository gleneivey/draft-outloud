class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_book_footer

  def self.cache_dir() @cache_dir ||= Rails.root.join 'book-cache'; end
  def self.fragments() @fragments ||=
    ApplicationController.cache_dir.join 'fragments'; end
  def self.page_footer() @page_footer ||= 
    ApplicationController.fragments.join 'page-footer.html'; end

  private

  def load_book_footer
    return nil unless File.exists?(ApplicationController.page_footer)
    @book_footer_html = IO.read(ApplicationController.page_footer).strip
  end
end
