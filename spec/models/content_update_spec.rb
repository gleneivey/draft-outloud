require 'spec_helper'

describe ContentUpdate do
  it "can be instantiated" do
    content_update = nil
    lambda { 
      content_update = ContentUpdate.create
    }.should change { ContentUpdate.count }.by(1)

    ContentUpdate.find(content_update.id).should == content_update
  end
end
