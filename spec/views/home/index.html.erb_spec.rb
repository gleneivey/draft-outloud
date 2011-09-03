require 'spec_helper'

describe "home/index.html.erb" do
  it "shows customizations from the database" do
    title = "Doing Stuff"
    assign :title, title
    subtitle = "For Dummies"
    assign :subtitle, subtitle
    book_file_name = "this-book"
    assign :book_file_name, book_file_name

    render

    rendered.should have_xpath "//div[@class='title'][.='#{title}']"
    rendered.should have_xpath "//div[@class='subtitle'][.='#{subtitle}']"
    rendered.should have_xpath "//a[@href='/#{book_file_name}.pdf'][.='Download PDF']"
    rendered.should have_xpath "//a[@href='/#{book_file_name}.html'][.='Download HTML']"
  end
end
