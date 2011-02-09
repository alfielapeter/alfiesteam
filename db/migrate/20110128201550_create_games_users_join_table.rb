class CreateGamesUsersJoinTable < ActiveRecord::Migration
  def self.up
		  create_table :games_users do |t|
	      t.integer :game_id
	      t.integer :user_id
				t.boolean :attending
	      t.timestamps
	    end
	  end

	  def self.down
			drop_table :games_users
  end
end
