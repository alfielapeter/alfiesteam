class UserMailer < ActionMailer::Base
  default :from => "AlfiesTeam@alfieste.am"

  def game_reminder(player, game)
    @game = game
    @player = player
    mail :to => "#{player.name}<#{player.email}>",
         :from => "#{game.team.name}<no-reply@alfieste.am>",
         :subject => "#{game.team.name} Game Reminder",
         :content_type => "text/html"
  end

  def help(message)
    mail :to => "alfie@alfielapeter.com",
         :from => message[:email],
         :subject => "alfiesteam help",
         :body => message[:body]
  end
end