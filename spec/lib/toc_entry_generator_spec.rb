require 'spec_helper'

require File.join(File.dirname(__FILE__),
                  '..', '..', 'lib', 'toc_entry_generator')

TEMP_FILE_DIRECTORY = ENV['RSPEC_TMP_DIR'] || File.join(File.dirname(__FILE__),
    '..', '..', 'tmp', 'spec')

describe TocEntryGenerator do
  before do
    FileUtils.mkpath TEMP_FILE_DIRECTORY
    @temp_file_name =
        File.join(TEMP_FILE_DIRECTORY, 'toc_entry_generator_spec.html')
  end

  def test_html(html)
    html_file = File.open(@temp_file_name, 'w')
    html_file.puts html
    html_file.close
  end

  it "handles empty HTML files" do
    test_html <<-HTML
      <html>
      </html>
    HTML

    content_update = ContentUpdate.create! :checkout_target => "master"
    lambda {
      TocEntryGenerator.digest_book_html_into_database(
          @temp_file_name, content_update)
    }.should_not change { TocEntry.count }
    content_update.reload.successful.should_not be_true
  end

  it "creates TOC entries in database" do
    html = <<-HTML
      <html>
        <head></head>
        <body>
          <div class="book" title="Book of Information">
            <div xmlns="" xmlns:d="http://docbook.org/ns/docbook"
                class="titlepage">
              <div>
                <div>
                  <h1 xmlns="http://www.w3.org/1999/xhtml" class="title">
                    <a xmlns:saxon="http://icl.com/saxon"
                        id="book"/>
                      Book of Information
                  </h1>
                </div>
              </div>
            </div>

            <div class="section" title="Section 1's Title">
              <div xmlns="" xmlns:d="http://docbook.org/ns/docbook"
                  class="titlepage">
                <div>
                  <div>
                    <h3 xmlns="http://www.w3.org/1999/xhtml" class="title">
                      <a xmlns:saxon="http://icl.com/saxon"
                          id="sect1"/>
                        Section 1's Title
                    </h3>
                  </div>
                </div>
              </div>
    HTML

    3.times do |i|
      html += <<-HTML
              <div class="simplesect" title="Subsection #{i}">
                <div xmlns="" xmlns:d="http://docbook.org/ns/docbook"
                    class="titlepage">
                  <div>
                    <div>
                      <h4 xmlns="http://www.w3.org/1999/xhtml" class="title">
                        <a xmlns:saxon="http://icl.com/saxon"
                            id="sect1subsect#{i}"/>
                          Subsection #{i}
                      </h4>
                    </div>
                  </div>
                </div>
              </div>
      HTML
    end

    html += <<-HTML
            </div> <!-- end of section -->
          </div> <!-- end of book -->
        </body>
      </html>
    HTML
    test_html html

    content_update = ContentUpdate.create! :checkout_target => "master"
    lambda {
      TocEntryGenerator.digest_book_html_into_database(
          @temp_file_name, content_update)
    }.should change { TocEntry.count }.by(4)

    content_update.reload.successful.should_not be_true

    expected_entries = [
        { :element => 'section', :text => "Section 1's Title",
          :anchor => 'sect1', :level => 0 },
        { :element => 'simplesect', :text => "Subsection 0",
          :anchor => 'sect1subsect0', :level => 1 },
        { :element => 'simplesect', :text => "Subsection 1",
          :anchor => 'sect1subsect1', :level => 1 },
        { :element => 'simplesect', :text => "Subsection 2",
          :anchor => 'sect1subsect2', :level => 1 }
    ]
    TocEntry.find(:all, :order => 'id desc', :limit => 4).reverse.each_with_index do |entry, i|
      entry.content_update.should == content_update
      entry.docbook_element.should == expected_entries[i][:element]
      entry.entry_text.should == expected_entries[i][:text]
      entry.html_anchor.should == expected_entries[i][:anchor]
      entry.indent_level.should == expected_entries[i][:level]
    end
  end

  it "recognizes the tags for TOC entries" do
    sample_content = [
      {:text => "This Set", :class => 'set', :tag => 'h1'},
      {:text => "This Book", :class => 'book', :tag => 'h1'},
      {:text => "Book's First Part", :class => 'part', :tag => 'h1'},

      {:text => "Book's Appendix", :class => 'appendix', :tag => 'h2',
       :close => 1},
      {:text => "Book's Glossary", :class => 'glossary', :tag => 'h2',
       :close => 1},
      {:text => "Book's Index", :class => 'index', :tag => 'h2',
       :close => 1},
      {:text => "Book's First Chapter", :class => 'chapter', :tag => 'h2'},

      {:text => "Look at This Important Stuff", :class => 'bridgehead',
       :tag => 'h2', :close => 1},
      {:text => "More Important Stuff", :class => 'sidebar', :tag => 'h2',
       :close => 1},
      {:text => "Section", :class => 'sect1', :tag => 'h2'},
      {:text => "Subsection", :class => 'sect2', :tag => 'h3'},
      {:text => "Sub-Subsection", :class => 'sect3', :tag => 'h4'},
      {:text => "Sub-Sub-Subsection", :class => 'sect4', :tag => 'h5'},
      {:text => "SubX4-Section", :class => 'sect5', :tag => 'h6'},
      {:text => "SubX5-Section", :class => 'section', :tag => 'h7'},
      {:text => "SubX6-Section", :class => 'simplesect', :tag => 'h8'}
    ]

    test_with sample_content
  end

  it "works if the top-level element doesn't come first" do
    sample_content = [
      {:text => "This Book", :class => 'book', :tag => 'h1'},
      {:text => "Introductory Chapter", :class => 'chapter', :tag => 'h2',
       :close => 1, :level_adjust => 1},
      {:text => "Book's First Part", :class => 'part', :tag => 'h1'},
      {:text => "First Chapter", :class => 'chapter', :tag => 'h2'},
      {:text => "Section", :class => 'section', :tag => 'h3',
       :close => 2},
      {:text => "Second Chapter", :class => 'chapter', :tag => 'h2',
       :close => 1},
      {:text => "Third Chapter", :class => 'chapter', :tag => 'h2',
       :close => 1},
      {:text => "Fourth Chapter", :class => 'chapter', :tag => 'h2',
       :close => 1},
      {:text => "Fifth Chapter", :class => 'chapter', :tag => 'h2',
       :close => 2},
      {:text => "Book's Second Part", :class => 'part', :tag => 'h1'},
      {:text => "Sixth Chapter", :class => 'chapter', :tag => 'h2',
       :close => 1},
      {:text => "Seventh Chapter", :class => 'chapter', :tag => 'h2',
       :close => 1},
      {:text => "Eighth Chapter", :class => 'chapter', :tag => 'h2',
       :close => 1}
    ]

    test_with sample_content, 1
  end

  def test_with(sample_content, starting_indent_level = 0)
    html = <<-HTML
      <html>
        <head></head>
        <body>
    HTML

    number_of_levels = 0
    sample_content.each do |h|
      html += <<-HTML
          <div class="#{h[:class]}" title="#{h[:text]}">
            <div xmlns="" xmlns:d="http://docbook.org/ns/docbook"
                class="titlepage">
              <div>
                <div>
                  <#{h[:tag]} xmlns="http://www.w3.org/1999/xhtml" class="title">
                    <a xmlns:saxon="http://icl.com/saxon"
                        id="id_#{h[:class]}"/>
                      #{h[:text]}
                  </#{h[:tag]}>
                </div>
              </div>
            </div>
      HTML

      number_of_levels += 1
      if h[:close]
        h[:close].times { html += "</div>" }
        number_of_levels -= h[:close]
      end
    end

    number_of_levels.times { html += "</div>" }
    html += <<-HTML
        </body>
      </html>
    HTML
    test_html html

    new_entry_count = sample_content.length - 1
    content_update = ContentUpdate.create! :checkout_target => "master"
    lambda {
      TocEntryGenerator.digest_book_html_into_database(
          @temp_file_name, content_update)
    }.should change { TocEntry.count }.by(new_entry_count)

    content_update.reload.successful.should_not be_true

    level = starting_indent_level
    TocEntry.find(:all, :order => 'id desc', :limit => new_entry_count).reverse.each_with_index do |entry, j|
      i = j+1

      entry.content_update.should == content_update
      entry.docbook_element.should == sample_content[i][:class]
      entry.entry_text.should == sample_content[i][:text]
      entry.html_anchor.should == "id_#{sample_content[i][:class]}"
      entry.indent_level.should == level

      level += 1
      if sample_content[i][:close]
        level -= sample_content[i][:close]
      end
      if sample_content[i][:level_adjust]
        level -= sample_content[i][:level_adjust]
      end
    end
  end
end
