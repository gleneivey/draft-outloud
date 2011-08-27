require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    it "should be successful" do
      short_title = "Cool Book"
      subtitle = "everything I know"
      file_name = "my-book"
      Customization.create(
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
  end
end
