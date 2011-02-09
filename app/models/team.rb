class Team < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :games, :dependent => :destroy
	
	validates_presence_of :name, :on => :create, :message => "can't be blank"
	validates_presence_of :location, :on => :create, :message => "can't be blank"
	validates_presence_of :league, :on => :create, :message => "can't be blank"

end
