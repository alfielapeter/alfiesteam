class ConvertTeamsUsersToJoin < ActiveRecord::Migration
  def self.up
    add_column :teams_users, :id, :primary_key
  end

  def self.down
    remove_column :teams_users, :id
  end
end
