class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_timezone

  def set_timezone
    Time.zone = current_user.time_zone if current_user
  end

  protected
  helper_method :current_team, :captain?, :mobile_device?

  def current_team
    Team.find(session[:team_id]) if session[:team_id]
  end

  def captain?
    current_user && current_user.captain
  end

  def adjust_format_for_mobile_device
    if request.user_agent =~ /Mobile|webOS/
      request.format = :mobile
    end
  end

end