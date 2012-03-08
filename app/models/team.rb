class Team < ActiveRecord::Base
  has_many :teams_users, :dependent => :destroy
  has_many :users, :through => :teams_users
  has_many :games, :dependent => :destroy

  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :location, :on => :create, :message => "can't be blank"
  validates_presence_of :league, :on => :create, :message => "can't be blank"

end
# == Schema Information
#
# Table name: teams
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  league     :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

