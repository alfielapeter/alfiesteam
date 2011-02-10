class GamesController < ApplicationController
  before_filter :authenticate_user!
	before_filter :adjust_format_for_mobile_device, :only => [:show]

  def show
    @game = Game.find(params[:id])
		@team = @game.team
		@players = @team.users
		
    respond_to do |format|
      format.html # show.html.erb
			format.mobile 
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])
		@games = current_team.games
		
    respond_to do |format|
      if @game.save
				current_team.games << @game
				current_team.users.each{|u| @game.users << u}
        format.html { redirect_to(team_path(current_team), :notice => 'Game was successfully created.') }
				format.js
      else
        format.html { redirect_to :back }
      end
    end
  end

  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to(@game, :notice => 'Game was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end

	def attending
		@game = Game.find(params[:id])
		@ug = @game.games_users.where(:user_id => current_user.id).first
		@ug.update_attribute(:attending, true)

		respond_to do |format|
			format.html { redirect_to(game_path(@game), :notice => "You have been marked as ATTENDING this game.")}
		end
	end
	
	def not_attending
		@game = Game.find(params[:id])
		@ug = @game.games_users.where(:user_id => current_user.id).first
		@ug.update_attribute(:attending, false)
		
		respond_to do |format|
			format.html { redirect_to(game_path(@game), :notice => "You have been marked as NOT ATTENDING this game.")}
		end
	end
	
end