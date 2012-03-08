class AddTimeZonesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :time_zone, :string
    
    User.reset_column_information
    User.all.each{|u| u.update_attribute(:time_zone, "Mountain Time (US & Canada)")}
    
  end

  def self.down
    remove_column :users, :time_zone
  end
end
