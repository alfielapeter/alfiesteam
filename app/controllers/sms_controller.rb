class SmsController < ApplicationController

  def index
    @msg = params[:message].split(' ')
    @msg.shift
		@game = Game.find(@msg.at(0).to_i)
		@phone = params[:device_address][1..-1]
		@user = User.find_by_phone(@phone)
		@ug = GamesUser.first(:conditions => {:game_id => @game.id, :user_id => @user.id})
		if @msg.at(-1).downcase == "y"
			@ug.update_attribute(:attending, true)
		elsif @msg.at(-1).downcase == "n"
			@ug.update_attribute(:attending, false)
		end
		puts "game = #{@game.id}"
		puts "user = #{@user.name}"
		puts "attending? #{@ug.attending}"
		
		render :nothing => true  
	end

end
