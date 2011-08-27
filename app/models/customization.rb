class Customization < ActiveRecord::Base
  validates :book_title, :short_title, :book_root_file_path, :presence => true
end
