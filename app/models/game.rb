class Game < ActiveRecord::Base
	has_many :games_users, :dependent => :destroy
	has_many :users, :through => :games_users
	belongs_to :team
	
	validates_presence_of :start_at, :on => :create, :message => "can't be blank"
end