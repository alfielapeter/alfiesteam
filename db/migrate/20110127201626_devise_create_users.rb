class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
			t.invitable
			t.string 				:name
			t.string 				:phone
			t.boolean				:captain, :default => false
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  	add_index :users, :invitation_token
  end

  def self.down
    drop_table :users
  end
end
