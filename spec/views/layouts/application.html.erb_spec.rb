require 'spec_helper'

describe "layouts/application.html.erb" do
  it "head" do
    page_title = "Stuff"
    assign :page_title, page_title
    render
    rendered.should have_xpath "//head/title[.='#{page_title}']"
  end

  describe "page footer" do
    it "includes 'powered by' references to Draft Outloud" do
      page_title = "Stuff"
      assign :page_title, page_title

      render

      rendered.should =~ /Powered by/
      rendered.should have_xpath(
"//a[@href='https://github.com/gleneivey/draft-outloud/wiki'][.='Draft Outloud']")
      rendered.should =~ /Copyright/
      rendered.should have_xpath(
"//a[@href='http://www.gnu.org/licenses/agpl-3.0.html'][.='GNU AGPL v3']")
    end
  end
end
