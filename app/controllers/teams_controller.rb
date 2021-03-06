class TeamsController < ApplicationController
  before_filter do |controller|
    :authenticate_user! unless controller.request.format.ics?
  end

  def show
    @team = Team.find(params[:id])
    @players = @team.users
    @games = @team.games
    @game = Game.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
      format.ics  { render :text => @team.to_ics }
    end
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])
    @game = Game.new
    respond_to do |format|
      if @team.save
        current_user.teams << @team
        current_team = session[:team_id] = @team.id
        format.html { redirect_to(@team, :notice => 'Team was successfully created.') }
      else
        format.html { redirect_to :back, :alert => 'All fields are required. Please try again.' }
      end
    end
  end

  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to(@team, :notice => 'Team was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    session[:team_id] = current_user.teams.last
    redirect_to edit_user_registration_path(current_user), :notice => 'Team was successfully deleted.'
  end

  def change_team
    @team = Team.find(params[:team])
    session[:team_id] = @team.id

    respond_to do |format|
      format.html { redirect_to(team_path(@team))}
    end
  end

  def remove_player
    @player = User.find(params[:id])
    current_team.users.delete(@player)
    current_team.games.each do |g|
      ug = GamesUser.where(:game_id => g.id, :user_id => @player.id)
      ug.each {|x| x.destroy}
    end
    redirect_to(team_path(current_team), :notice => 'Player was successfully removed from this team')
  end

  def resend_invitation
    User.find(params[:id]).invite!
    redirect_to :back, :notice => "Invitation has been resent to that player."
  end
end