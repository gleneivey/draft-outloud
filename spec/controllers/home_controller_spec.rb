require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    it "should be successful" do
      short_title = "Cool Book"
      subtitle = "everything I know"
      Customization.create(
          :book_title => short_title+": "+subtitle,
          :short_title => short_title
        )

      get 'index'

      assigns[:title].should == short_title
      assigns[:subtitle].should == subtitle
      assigns[:page_title].should == short_title
      response.should be_success
    end

    it "handles a book title without a subtitle" do
      title = "My Book"
      short = "MB"
      Customization.create(
          :book_title => title,
          :short_title => short
        )

      get 'index'

      assigns[:title].should == title
      assigns[:subtitle].should be_nil
      assigns[:page_title].should == short
      response.should be_success
    end
  end
end
