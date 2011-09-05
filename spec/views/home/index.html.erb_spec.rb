require 'spec_helper'

describe "home/index.html.erb" do
  it "shows customizations from the database" do
    title = "Doing Stuff"
    assign :title, title
    subtitle = "For Dummies"
    assign :subtitle, subtitle
    book_file_name = "this-book"
    assign :book_file_name, book_file_name

    toc_entry_hashes = [
        { :level => 0, :text => "Chapter Heading" },
        { :level => 1, :text => "Section Heading", :number => "1." },
        { :level => 1, :text => "Section Heading", :number => "2." },
        { :level => 2, :text => "Subsection Heading", :number => "2.1" },
        { :level => 0, :text => "Chapter Heading" }
    ]
    assign :toc_entry_hashes, toc_entry_hashes

    render

    rendered.should have_xpath "//div[@class='title'][.='#{title}']"
    rendered.should have_xpath "//div[@class='subtitle'][.='#{subtitle}']"
    rendered.should have_xpath "//a[@href='/#{book_file_name}.pdf'][.='Download PDF']"
    rendered.should have_xpath "//a[@href='/#{book_file_name}.html'][.='Download HTML']"

    toc_entry_hashes.each do |hash|
      level_class = hash[:level].blank? ? 'no-level' : "level#{hash[:level]}"

      rendered.should have_xpath "//div[@class='entry #{level_class}']/span[@class='text'][.='#{hash[:text]}']"
      if hash[:number].present?
        rendered.should have_xpath "//div[@class='entry #{level_class}']/span[@class='number'][.='#{hash[:number]}']"
      else
        rendered.should_not have_xpath "//div[@class='entry #{level_class}']/span[@class='number']"
      end
    end
  end
end
