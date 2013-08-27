class SmsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # via Twilio
  def create
    game_id = params[:Body][/\d+/].to_i
    answer = params[:Body][/\D+/].gsub(/\s/, '')
    phone = params[:From][2..-1]

    user = User.find_by_phone(phone)
    ug = GamesUser.where(game_id: game_id, user_id: user.id).first

    attending = answer == "y" || answer == "yes"
    ug.update_attribute(:attending, attending)

    render nothing: true
  end

end
