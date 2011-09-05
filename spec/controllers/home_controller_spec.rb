require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    fixtures :content_updates, :toc_entries

    it "should be successful" do
      short_title = "Cool Book"
      subtitle = "everything I know"
      file_name = "my-book"
      Customization.create!(
          :book_title => short_title+": "+subtitle,
          :short_title => short_title,
          :book_root_file_path => "book/#{file_name}.xml"
        )

      get 'index'

      assigns[:title].should == short_title
      assigns[:subtitle].should == subtitle
      assigns[:page_title].should == short_title
      assigns[:book_file_name].should == file_name
      response.should be_success
    end

    it "handles a book title without a subtitle" do
      default_customization

      get 'index'

      assigns[:title].should == "My Book"
      assigns[:subtitle].should be_nil
      assigns[:page_title].should == "MB"
      assigns[:book_file_name].should == "my-book"
      response.should be_success
    end

    it "lists book's TOC entries" do
      Customization.create!(
        :book_title => "Cool-Tech: In a Nutshell",
        :short_title => "Cool-Tech",
        :book_root_file_path => "book/cool-tech.xml"
      )

      get 'index' # depend on fixtures for content_updates and toc_entries

      hashes = assigns[:toc_entry_hashes]
      hashes.first[:level].should == 0 # true regardless of book content

      # fixture dependent
      hashes.length.should == 31
      ## handles entry with XSLT-generated numbering
      hashes[2][:text].should == 'Overview'
      hashes[2][:number].should == 'Part I.'
      hashes[2][:level].should == 2
      hashes[3][:text].should == 'Introduction'
      hashes[3][:number].should == 'Chapter 1.'
      hashes[3][:level].should == 3
      ## handles entry without auto-numbering
      hashes[6][:text].should == 'First Major Section'
      hashes[6][:number].should be_nil
      hashes[6][:level].should == 3
      ## handles entries outside the normal nesting sequence
      hashes[4][:text].should == 'A Few Other Thoughts'
      hashes[4][:number].should be_nil
      hashes[4][:level].should be_nil
    end

    it "list TOC entries from latest successful update" do
      default_customization

      # fixtures provide first content_update record
      ContentUpdate.create! :created_at => 1.day.ago, :successful => true
      first_fail = ContentUpdate.create! :created_at => 90.minutes.ago
      update = ContentUpdate.create! :created_at => 75.minutes.ago, :successful => true
      second_fail = ContentUpdate.create!

      [first_fail, second_fail].each do |content_update|
        (0..2).each do |i|
          TocEntry.create(
            :docbook_element => 'heading',
            :content_update => content_update,
            :indent_level => i,
            :html_anchor => "a#{i}",
            :entry_text => "failed Level #{i+1} Header"
          )
        end
      end

      successful_toc = [
          [ 0, "Chapter Heading" ],
          [ 1, "Section Heading" ],
          [ 1, "Section Heading" ],
          [ 2, "Subsection Heading" ],
          [ 0, "Chapter Heading" ]
      ]
      successful_toc.each_with_index do |content, i|
        TocEntry.create(
          :docbook_element => 'heading',
          :content_update => update,
          :indent_level => content[0],
          :html_anchor => "a#{i}",
          :entry_text => content[1]
        )
      end

      get 'index'

      hashes = assigns[:toc_entry_hashes]
      hashes.length.should == 5
      hashes.each_with_index do |hash, i|
        hash[:number].should == nil
        hash[:text].should == successful_toc[i][1]
        hash[:level].should == successful_toc[i][0]
      end
    end
  end
end
