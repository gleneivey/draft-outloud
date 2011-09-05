class TocEntry < ActiveRecord::Base
  belongs_to :content_update
  validates :content_update_id, :presence => true
end
