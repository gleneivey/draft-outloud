require 'spec_helper'

describe Customization do
  it "can be instantiated" do
    c = Customization.new(
        :book_title => "My Book: Written in XML",
        :short_title => "My Book"
      )
    c.save!
    Customization.find_by_short_title("My Book").should == c
  end

  it "validates" do
    lambda {
      Customization.create(:book_title => "title: subtitle").should be_invalid
      Customization.create(:short_title => "title").should be_invalid
      Customization.create(
          :book_title => "title: subtitle",
          :short_title => "title"
        ).should be_valid
    }.should change { Customization.count }.by(1)
  end
end
