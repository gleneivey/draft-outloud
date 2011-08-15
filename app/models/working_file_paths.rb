
class WorkingFilePaths
  def initialize(directory_name)
    @directory = Rails.root.join directory_name
  end

  def web()         @web         ||= @directory.join 'web'; end
  def fragments()   @fragments   ||= web.join 'fragments'; end
  def page_footer() @page_footer ||= fragments.join 'page_footer.html'; end
end
