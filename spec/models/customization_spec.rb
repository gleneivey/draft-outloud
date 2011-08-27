require 'spec_helper'

describe Customization do
  it "can be instantiated" do
    c = default_customization
    c.save!
    Customization.find_by_short_title("MB").should == c
  end

  it "validates" do
    required_attributes = {
      :book_title => "title: subtitle",
      :short_title => "title",
      :book_root_file_path => "book/book.xml"
    }
    
    lambda {
      required_attributes.keys.each do |attribute_to_exclude|
        attributes = required_attributes.clone
        attributes.delete attribute_to_exclude
        Customization.create(attributes).should be_invalid
      end

      Customization.create(required_attributes).should be_valid
    }.should change { Customization.count }.by(1)
  end
end
