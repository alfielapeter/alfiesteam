require 'spec_helper'

describe SmsController do
  let(:game) { Factory(:game) }
  let(:user) { Factory(:user, phone: "8002083545") }
  let(:params) { {Body: "#{game.id} y", From: "+18002083545"} }
  let!(:games_user) { Factory(:games_user, game_id: game.id, user_id: user.id) }

  describe "POST 'create'" do
    it "should parse a text message" do
      post :create, params
      response.should be_success
    end

    it "should mark the user as 'yes' for this game" do
      post :create, params
      games_user.reload.attending.should == true
    end

    it "should mark the user as a 'no' for this game" do
      post :create, params.merge({Body: "#{game.id} n"})
      games_user.reload.attending.should == false
    end

    it "should mark the user as 'yes' for this game" do
      post :create, params.merge({Body: "#{game.id} yes"})
      games_user.reload.attending.should == true
    end

    it "should mark the user as a 'no' for this game" do
      post :create, params.merge({Body: "#{game.id} no"})
      games_user.reload.attending.should == false
    end
  end
end
