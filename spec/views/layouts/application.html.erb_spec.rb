require 'spec_helper'

describe "layouts/application.html.erb" do
  before do
    assign :book_footer_html, "don't care"
  end

  it "head" do
    page_title = "Stuff"
    assign :page_title, page_title
    render
    rendered.should have_xpath "//head/title[.='#{page_title}']"
  end

  describe "page footer" do
    it "includes HTML snippet from book content" do
      snippet = "<div class=\"fu\"><span class='bar'>this is some&mdash;</span> HTML.</div>"
      assign :book_footer_html, snippet

      render

      rendered.should include snippet
    end

    it "includes 'powered by' references to Draft Outloud" do
      page_title = "Stuff"
      assign :page_title, page_title

      render

      rendered.should =~ /Powered by/
      rendered.should have_xpath(
"//a[@href='https://github.com/gleneivey/draft-outloud/wiki'][.='Draft Outloud']")
      rendered.should have_xpath(
"//a[@href='http://www.gnu.org/licenses/agpl-3.0.html'][.='GNU AGPL v3']")
    end

    describe "Draft Outloud copyright notice in footer" do
      it "is included" do
        Customization.create(
            :book_title => "My Book",
            :short_title => "MB"
          )
        render
        rendered.should match /Copyright.*Glen E\. Ivey/
      end

      it "is omitted" do
        Customization.create(
            :book_title => "My Book",
            :short_title => "MB",
            :suppress_sw_copyright_notice => true
          )
        render
        rendered.should_not match /Copyright.*Glen E\. Ivey/
      end
    end
  end
end
