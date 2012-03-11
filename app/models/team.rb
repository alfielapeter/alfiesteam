class Team < ActiveRecord::Base
  has_many :teams_users, :dependent => :destroy
  has_many :users, :through => :teams_users
  has_many :games, :dependent => :destroy

  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :location, :on => :create, :message => "can't be blank"
  validates_presence_of :league, :on => :create, :message => "can't be blank"

  def to_ics
    RiCal.Calendar do |cal|
      self.games.future.each do |game|
        cal.event do |event|
          event.summary = "#{self.name} Game"
          event.dtstart = game.start_at
          event.dtend = game.start_at + 1.hour
          event.location = self.location
        end
      end
    end
  end
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

