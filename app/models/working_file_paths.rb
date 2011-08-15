
class WorkingFilePaths
  def initialize(directory_name)
    @directory = Rails.root.join directory_name
  end

  def fragments()   @fragments   ||= @directory.join 'fragments'; end
  def page_footer() @page_footer ||= fragments.join 'page_footer.html'; end
end
