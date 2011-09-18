class Customization < ActiveRecord::Base
  validates :book_title, :short_title, :book_root_file_path, :repository_url,
      :presence => true
end
