class Game < ActiveRecord::Base
  has_many :games_users, :dependent => :destroy
  has_many :users, :through => :games_users
  belongs_to :team

  validates_presence_of :start_at, :on => :create, :message => "can't be blank"

  scope :future, lambda{ where('start_at >= ?', Time.now) }

end
# == Schema Information
#
# Table name: games
#
#  id         :integer         not null, primary key
#  start_at   :datetime
#  team_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

