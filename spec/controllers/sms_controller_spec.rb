require 'spec_helper'

describe SmsController do

  describe "GET 'index'" do

    let(:game) { Factory(:game) }
    let(:user) { Factory(:user, :phone => "8002083545") }
    let(:params) { {:message => "game #{game.id} y", :device_address => "18002083545"} }
    let!(:games_user) { Factory(:games_user, :game_id => game.id, :user_id => user.id) }

    it "should parse a text message" do
      get 'index', params
      response.should be_success
    end
  end

end
