class PagesController < ApplicationController
	
	def index
		@team = Team.new
	end
	
end