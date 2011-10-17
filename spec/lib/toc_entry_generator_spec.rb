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
    TocEntry.all.each_with_index do |entry, i|
      entry.content_update.should == content_update
      entry.docbook_element.should == expected_entries[i][:element]
      entry.entry_text.should == expected_entries[i][:text]
      entry.html_anchor.should == expected_entries[i][:anchor]
      entry.indent_level.should == expected_entries[i][:level]
    end
  end
end
