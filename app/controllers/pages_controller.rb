class PagesController < ApplicationController
	
	def index
		@team = Team.new
	end
	
	def about
		if request.post?
	    UserMailer.help(params[:message]).deliver
			flash.now[:notice] = 'Thank you, your message has been sent.'
			render :action => "about"
		end
	end
	
end