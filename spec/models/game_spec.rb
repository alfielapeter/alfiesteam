require 'spec_helper'

describe Game do

	it "should have many users" do
		game = Factory.create(:game)
		game.users << Factory.create(:user)
		game.users << Factory.create(:user)
		game.should have(2).users
	end
	
	it "should have one team" do
		game = Factory.create(:game)
		team = Factory.create(:team)
		game.team = team
		game.team.should eq(team)
	end
	
end
