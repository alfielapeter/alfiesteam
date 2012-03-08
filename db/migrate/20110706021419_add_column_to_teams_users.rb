class AddColumnToTeamsUsers < ActiveRecord::Migration
  def self.up
    add_column :teams_users, :captain_at, :datetime
  end

  def self.down
    remove_column :teams_users, :captain_at
  end
end
