class ApplicationController < ActionController::Base
  protect_from_forgery
	layout "application"
	helper_method :current_team, :captain?
	
	protected
	
	def current_team
		Team.find(session[:team_id]) if session[:team_id]
	end

	def captain?
		current_user && current_user.captain
	end
	
end