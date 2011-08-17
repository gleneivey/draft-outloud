class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_book_footer

  def self.repo_dir()  @repo_dir  ||= WorkingFilePaths.new('book-repo');    end
  def self.work_dir()  @work_dir  ||= WorkingFilePaths.new('book-working'); end
  def self.cache_dir() @cache_dir ||= WorkingFilePaths.new('book-cache');   end

  private

  def load_book_footer
    @book_footer_html = ''
    return unless File.exists?(ApplicationController.cache_dir.page_footer)
    @book_footer_html = IO.read(ApplicationController.cache_dir.page_footer).strip
  end
end
