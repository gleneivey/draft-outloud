class Customization < ActiveRecord::Base
  validates :book_title, :short_title, :presence => true
end
