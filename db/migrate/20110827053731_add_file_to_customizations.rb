class AddFileToCustomizations < ActiveRecord::Migration
  def self.up
    add_column :customizations, :book_root_file_path, :string, :null => false
  end

  def self.down
    remove_column :customizations, :book_root_file_path
  end
end
