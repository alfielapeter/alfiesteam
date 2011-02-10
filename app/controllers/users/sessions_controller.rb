class Users::SessionsController < Devise::SessionsController
	before_filter :adjust_format_for_mobile_device, :only => [:new]
	
	def create
		super
		if current_user.teams.size > 0
			session[:team_id] = current_user.teams.last.id
		end
	end
	
  def destroy
    super
    reset_session
  end
end