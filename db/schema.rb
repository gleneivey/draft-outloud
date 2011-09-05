# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110905061505) do

  create_table "content_updates", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "checkout_target"
    t.boolean  "successful",      :default => false
  end

  create_table "customizations", :force => true do |t|
    t.string   "book_title",                                      :null => false
    t.string   "short_title",                                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "suppress_sw_copyright_notice", :default => false, :null => false
    t.string   "book_root_file_path",                             :null => false
  end

  create_table "toc_entries", :force => true do |t|
    t.string  "docbook_element"
    t.string  "entry_text"
    t.string  "html_anchor"
    t.integer "indent_level"
    t.integer "content_update_id", :null => false
  end

end
