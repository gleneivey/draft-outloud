require 'spec_helper'

describe "layouts/application.html.erb" do
  describe "page footer" do
    it "includes 'powered by' references to Draft Outloud" do
      render

      rendered.should =~ /Powered by/
      rendered.should have_selector(
          'a[href="https://github.com/gleneivey/draft-outloud/wiki"]') do |a|
        a.should =~ /^Draft Outloud$/
      end
      rendered.should =~ /Copyright/
      rendered.should have_selector(
          'a[href="http://www.gnu.org/licenses/agpl-3.0.html"]') do |a|
        a.should =~ /^GNU AGPL v3$/
      end
    end
  end
end
