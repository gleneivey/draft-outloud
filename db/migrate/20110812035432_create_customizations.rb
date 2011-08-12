class CreateCustomizations < ActiveRecord::Migration
  def self.up
    create_table :customizations do |t|
      t.string "book_title", :null => false
      t.string "short_title", :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :customizations
  end
end
