require 'spec_helper'

describe Team do
  
	it "should have team members" do
	  team = Factory.create(:team)
		team.users << Factory.create(:user)
		team.users << Factory.create(:user)
	  team.should have(2).users
	end
	
	it "should have many games" do
		team = Factory.create(:team)
		team.games << Factory.create(:game)
		team.games << Factory.create(:game)
		team.should have(2).games
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

