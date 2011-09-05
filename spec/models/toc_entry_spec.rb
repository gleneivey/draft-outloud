require 'spec_helper'

describe TocEntry do
  it "can be instantiated" do
    content_update = ContentUpdate.create
    toc_entry = nil
    lambda { 
      toc_entry = TocEntry.create :content_update => content_update
    }.should change { TocEntry.count }.by(1)

    TocEntry.find(toc_entry.id).should == toc_entry
  end

  it "validates" do
    toc_entry = TocEntry.new
    lambda {
      toc_entry.save.should be_false
      toc_entry.should be_invalid
    }.should_not change { TocEntry.count }
  end
end
