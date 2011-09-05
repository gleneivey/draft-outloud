class AddTocEntryAndContentUpdateTables < ActiveRecord::Migration
  def up
    create_table :content_updates do |t|
      t.timestamps
      t.string 'checkout_target'
      t.boolean 'successful', :default => false
    end

    create_table :toc_entries do |t|
      t.string 'docbook_element'
      t.string 'entry_text'
      t.string 'html_anchor'
      t.integer 'indent_level'
      t.integer 'content_update_id', :null => false
    end
  end

  def down
    drop_table :content_updates
    drop_table :toc_entries
  end
end
