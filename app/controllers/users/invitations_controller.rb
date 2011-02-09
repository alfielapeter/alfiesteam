class Users::InvitationsController < Devise::InvitationsController
	
	def create
		if User.exists?(:email => params[:user][:email])
			@player = User.find_by_email(params[:user][:email])
			if current_team.users.include?(@player)
				set_flash_message :alert, "That player is already on this team."
			else
				current_team.users << @player
				current_team.games.each {|g| GamesUser.create(:game_id => g.id, :user_id => @player.id)}
				set_flash_message :notice, "Good news! That player is already in our system and has been added to your team."
    	end
			redirect_to team_path(current_team)
		else
			@player = User.invite!(params[:user])
		
    	if @player.errors.empty?
				current_team.users << @player
				current_team.games.each {|g| GamesUser.create(:game_id => g.id, :user_id => @player.id)}
	      set_flash_message :notice, :send_instructions
	      redirect_to team_path(current_team)
			else
				set_flash_message :alert, "#{@player.errors.full_messages}. Please try inviting that player again."
	      redirect_to :back
	    end
		end
	end
	
  def update
    self.resource = resource_class.accept_invitation!(params[resource_name])

    if resource.errors.empty?
      set_flash_message :notice, :updated
      sign_in_and_redirect(resource_name, resource)
			session[:team_id] = current_user.teams.last.id
    else
      render_with_scope :edit
    end
  end
	
end