require 'spec_helper'

describe User do
  
	  it "should be allowed on more than one team" do
			user = Factory.create(:user)
			user.teams << Factory.create(:team)
			user.teams << Factory.create(:team)
	  	user.should have(2).teams
		end
	  
		it "should have more than one game" do
			user = Factory.create(:user)
			user.games << Factory.create(:game)
			user.games << Factory.create(:game)
			user.should have(2).games
		end
end


# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  invitation_token     :string(20)
#  invitation_sent_at   :datetime
#  name                 :string(255)
#  phone                :string(255)
#  captain              :boolean         default(FALSE)
#  created_at           :datetime
#  updated_at           :datetime
#  time_zone            :string(255)
#

