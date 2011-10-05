require 'spec_helper'

describe "home/index.html.erb" do
  before do
    @title = "Doing Stuff"
    assign :title, @title
    @subtitle = "For Dummies"
    assign :subtitle, @subtitle
    @book_file_name = "this-book"
    assign :book_file_name, @book_file_name
  end

  it "shows customizations from the database" do
    toc_entry_hashes = [
        { :level => 0, :text => "Chapter Heading" },
        { :level => 1, :text => "Section Heading", :number => "1." },
        { :level => 1, :text => "Section Heading", :number => "2." },
        { :level => 2, :text => "Subsection Heading", :number => "2.1" },
        { :level => 0, :text => "Chapter Heading" }
    ]
    assign :toc_entry_hashes, toc_entry_hashes

    render

    rendered.should have_xpath "//div[@class='title'][.='#{@title}']"
    rendered.should have_xpath "//div[@class='subtitle'][.='#{@subtitle}']"
    rendered.should have_xpath "//a[@href='/#{@book_file_name}.pdf'][.='Download PDF']"
    rendered.should have_xpath "//a[@href='/#{@book_file_name}.html'][.='Download HTML']"

    toc_entry_hashes.each do |hash|
      level_class = hash[:level].blank? ? 'no-level' : "level#{hash[:level]}"
      default_expand = hash[:level] == 0 ? 'expanded' : 'folded'

      rendered.should have_xpath "//div[@class='entry #{level_class} #{default_expand}']/span[@class='text'][.='#{hash[:text]}']"
      if hash[:number].present?
        rendered.should have_xpath "//div[@class='entry #{level_class} #{default_expand}']/span[@class='number'][.='#{hash[:number]}']"
      else
        rendered.should_not have_xpath "//div[@class='entry #{level_class} #{default_expand}']/span[@class='number']"
      end
    end
  end

  it "handles TOCs that start at a non-0 indent level" do
    toc_entry_hashes = [
        { :level => 1, :text => "Before-a-Part Chapter", :number => "1." },
        { :level => 0, :text => "Part the First",        :number => "I." },
        { :level => 1, :text => "Chapter",               :number => "2." },
        { :level => 1, :text => "Chapter",               :number => "3." },
        { :level => 2, :text => "Section",               :number => "3.1" },
        { :level => 1, :text => "Chapter",               :number => "4." },
        { :level => 0, :text => "Second Part",           :number => "II." },
        { :level => 1, :text => "Chapter",               :number => "5." },
        { :level => 1, :text => "Chapter",               :number => "6." },
        { :level => 1, :text => "Chapter",               :number => "7." },
        { :level => 1, :text => "Chapter",               :number => "8." }
    ]
    assign :toc_entry_hashes, toc_entry_hashes

    render

    rendered.should have_xpath "//div[@id='toc']/div[@class='entry level1 folded']/span[.='Before-a-Part Chapter']"
    rendered.should have_xpath "//div[@id='toc']/div[@class='entry level0 expanded']/span[.='Part the First']"
  end
end
