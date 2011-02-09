class UserMailer < ActionMailer::Base
  default :from => "help@alfieste.am"

  def game_reminder(player, game)
		@game = game
		@player = player
    mail :to => "#{player.name}<#{player.email}>", :from => "#{game.team.name}<no-reply@alfieste.am>", 
			:subject => "#{game.team.name} Game Reminder"
  end

end