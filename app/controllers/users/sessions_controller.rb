class Users::SessionsController < Devise::SessionsController
  respond_to :html

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