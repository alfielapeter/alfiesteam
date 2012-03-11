class GamesUser < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
end
# == Schema Information
#
# Table name: games_users
#
#  id         :integer         not null, primary key
#  game_id    :integer
#  user_id    :integer
#  attending  :boolean
#  created_at :datetime
#  updated_at :datetime
#

