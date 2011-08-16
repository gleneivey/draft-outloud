class AddSuppressSwCopyrightNoticeToCustomizations < ActiveRecord::Migration
  def self.up
    add_column :customizations, :suppress_sw_copyright_notice, :boolean,
        :default => false, :null => false
  end

  def self.down
    remove_column :customizations, :suppress_sw_copyright_notice
  end
end
