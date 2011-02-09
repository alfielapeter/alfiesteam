require 'spec_helper'
require 'devise/test_helpers'

describe "games/show.html.erb" do
  before(:each) do
	  sign_in Factory(:user)
    @game = assign(:game, Factory(:game))
		@team = assign(:team, stub_model(Team))
  end

  it "renders attributes in <p>" 
    #render
 
end
