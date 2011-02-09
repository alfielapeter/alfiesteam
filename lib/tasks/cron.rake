desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

	#check for games in the next 24 hours and send a reminder email
	@games_tomorrow = Game.where(:start_at => 23.hours.from_now..24.hours.from_now)
	@games_tomorrow.each do |g|
		g.users.each do |u|
			u.send_reminder_email(g)
			puts "email sent to: #{u.email}"
		end
	end
	
	#check for games in the next 4 hours and send a reminder text message
	@games_today = Game.where(:start_at => 3.hours.from_now..4.hours.from_now)
	@games_today.each do |g|
		g.users.each do |u|
			u.send_reminder_text(g)
			puts "text sent to: #{u.phone}"
		end
	end
	
end