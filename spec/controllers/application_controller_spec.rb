require 'spec_helper'

class GenericController < ApplicationController
  def action
    render :text => 'ok'
  end
end

describe GenericController do
  before do
    FileUtils.mkpath ApplicationController.fragments
  end

  describe "book-specific footer" do
    it "includes HTML from file-system cache" do
      snippet = "Some <i>cool</i> content!"
      html = File.open(ApplicationController.page_footer, "w")
      html.puts snippet
      html.close

      get :action
      assigns[:book_footer_html].should == snippet
    end

    it "loads an empty string if the cache is empty" do
      FileUtils.rm_f ApplicationController.page_footer
      get :action
      assigns[:book_footer_html].should be_nil
    end
  end
end
