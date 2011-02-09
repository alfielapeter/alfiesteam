require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe GamesController do

  before do
    sign_in Factory.create(:user)
  end
  
  def mock_game(stubs={})
    @mock_game ||= mock_model(Game, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all games as @games" do
      Game.stub(:all) { [mock_game] }
      get :index
      assigns(:games).should eq([mock_game])
    end
  end

  describe "GET show" do
    it "assigns the requested game as @game" do
      Game.stub(:find).with("37") { mock_game }
      get :show, :id => "37"
      assigns(:game).should be(mock_game)
    end
  end

  describe "GET new" do
    it "assigns a new game as @game" do
      Game.stub(:new) { mock_game }
      get :new
      assigns(:game).should be(mock_game)
    end
  end

  describe "GET edit" do
    it "assigns the requested game as @game" do
      Game.stub(:find).with("37") { mock_game }
      get :edit, :id => "37"
      assigns(:game).should be(mock_game)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "saves a game with .js format" do
				controller.stub!(:current_team).and_return(Factory(:team))
				controller.stub!(:current_user).and_return(Factory(:user))
        post :create, :game => Factory.attributes_for(:game), :format => :js
				response.should be_success
			end
    end

    describe "with invalid params" do
      it "redirects back" do
				controller.stub!(:current_team).and_return(Factory(:team))
				request.env["HTTP_REFERER"] = "http://whatever"
        post :create, :game => {}
        response.should be_redirect
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested game" do
        Game.stub(:find).with("37") { mock_game }
        mock_game.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :game => {'these' => 'params'}
      end

      it "assigns the requested game as @game" do
        Game.stub(:find) { mock_game(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:game).should be(mock_game)
      end

      it "redirects to the game" do
        Game.stub(:find) { mock_game(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(game_url(mock_game))
      end
    end

    describe "with invalid params" do
      it "assigns the game as @game" do
        Game.stub(:find) { mock_game(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:game).should be(mock_game)
      end

      it "re-renders the 'edit' template" do
        Game.stub(:find) { mock_game(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game" do
      Game.stub(:find).with("37") { mock_game }
      mock_game.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the games list" do
      Game.stub(:find) { mock_game }
      delete :destroy, :id => "1"
      response.should redirect_to(games_url)
    end
  end

	describe "Attending" do
		before do
			@user = Factory(:user)
			controller.stub!(:current_user).and_return(@user)
			@team = Factory(:team)
			controller.stub!(:current_team).and_return(@team)
			@game = Factory(:game)
			@game.users << @user
		end

		it "is true when attending" do
			post :attending, :id => @game.id
			assigns(:ug).attending.should == true
			response.should redirect_to(team_path(@team))
		end
		
		it "is false when not attending" do
			post :not_attending, :id => @game.id
			assigns(:ug).attending.should == false
			response.should redirect_to(team_path(@team))
		end
	end

end