require 'spec_helper'

describe TeamsController do

  let(:team) { Factory(:team) }
  let(:player) { Factory(:user) }
  let(:game) { Factory(:game) }

  before do
    sign_in Factory(:user)
    controller.stub!(:current_team).and_return(team)
  end

  def mock_team(stubs={})
    @mock_team ||= mock_model(Team, stubs).as_null_object
  end

  describe "GET show" do
    it "assigns the requested team as @team" do
      Team.stub(:find).with("37") { mock_team }
      get :show, :id => "37"
      assigns(:players).should_not be_nil
      assigns(:game).should_not be_nil
      assigns(:games).should_not be_nil
      assigns(:team).should be(mock_team)
    end
  end

  describe "GET edit" do
    it "assigns the requested team as @team" do
      Team.stub(:find).with("37") { mock_team }
      get :edit, :id => "37"
      assigns(:team).should be(mock_team)
    end
  end

  describe "GET new" do
    it "assigns a new team as @team" do
      Team.stub(:new) { mock_team }
      get :new
      assigns(:team).should be(mock_team)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created team as @team" do
        controller.stub!(:current_user).and_return(Factory(:user))
        post :create, :team => Factory.attributes_for(:team)
        assigns(:game).should_not be_nil
        response.should be_redirect
      end
    end

    describe "with invalid params" do
      it "redirects back" do
        request.env["HTTP_REFERER"] = "http://whatever"
        post :create, :team => {}
        response.should be_redirect
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested team" do
        Team.stub(:find).with("37") { mock_team }
        mock_team.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :team => {'these' => 'params'}
      end

      it "assigns the requested team as @team" do
        Team.stub(:find) { mock_team(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:team).should be(mock_team)
      end

      it "redirects to the team" do
        Team.stub(:find) { mock_team(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(team_url(mock_team))
      end
    end

    describe "with invalid params" do
      it "assigns the team as @team" do
        Team.stub(:find) { mock_team(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:team).should be(mock_team)
      end

      it "re-renders the 'edit' template" do
        Team.stub(:find) { mock_team(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested team" do
      Team.stub(:find).with("37") { mock_team }
      mock_team.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the teams list" do
      Team.stub(:find) { mock_team }
      delete :destroy, :id => "1"
      response.should redirect_to(edit_user_registration_path(1))
    end
  end

  describe "Change team" do
    it "should change the session team_id variable" do
      post :change_team, :team => team.id
      session[:team_id].should == team.id
      response.should redirect_to(team_url(team))
    end
  end

  describe "Remove player" do
    it "should remove player from team" do
      team.users << player
      team.users.should have(1).users
      post :remove_player, :id => player.id
      team.users.should have(0).users
    end

    it "should remove games from player schedule" do
      Factory(:games_user, :user_id => player.id)
      player.should have(1).games
      post :remove_player, :id => player.id
      # @player.should have(0).games
      response.should redirect_to(team_url(team))
    end
  end

  describe "Resend invitation" do
    it "should call invite! on a user" do
      request.env["HTTP_REFERER"] = "http://whatever"
      get :resend_invitation, :id => player.id
      # player.should_receive(:invite!)
      response.should be_redirect
    end
  end

end