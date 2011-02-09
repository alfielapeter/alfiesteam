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
