class CreateTeamsUsersJoinTable < ActiveRecord::Migration
  def self.up
	  create_table :teams_users, :id => false do |t|
      t.integer :team_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
		drop_table :teams_users
  end
end
