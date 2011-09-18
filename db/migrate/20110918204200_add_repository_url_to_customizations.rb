class AddRepositoryUrlToCustomizations < ActiveRecord::Migration
  def self.up
    add_column :customizations, :repository_url, :string, :null => false
  end

  def self.down
    remove_column :customizations, :repository_url
  end
end
