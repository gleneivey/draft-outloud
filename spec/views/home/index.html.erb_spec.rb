require 'spec_helper'

describe "home/index.html.erb" do
  it "shows customizations from the database" do
    title = "Doing Stuff"
    assign :title, title
    subtitle = "For Dummies"
    assign :subtitle, subtitle

    render

    rendered.should have_xpath "//div[@class='title'][.='#{title}']"
    rendered.should have_xpath "//div[@class='subtitle'][.='#{subtitle}']"
  end
end
