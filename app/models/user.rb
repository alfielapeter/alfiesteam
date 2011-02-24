class User < ActiveRecord::Base
	has_many :games_users, :dependent => :destroy
	has_and_belongs_to_many :teams
	has_many :games, :through => :games_users
	
  devise :database_authenticatable, :registerable, :recoverable, 
				 :rememberable, :trackable, :validatable, :invitable

	validates_presence_of :name, :message => "can't be blank."
	validates_presence_of :phone, :message => "can't be blank.", :if => :invited_or_captain
	validates_length_of 	:phone, :is => 10, :message => "must be 10 digits.", :if => :invited_or_captain
	validates_format_of 	:phone, :with => /^[\d]+$/, :message => "is invalid. Just enter digits, no spaces or dashes", :if => :invited_or_captain

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :phone, :captain

	# Don't want to validate phone number on the captain's invitation 
	# so only check on new user form (captain) or on invitation response.
	def invited_or_captain
		self.captain || invited?
	end
	
	def send_reminder_email(game)
		UserMailer.game_reminder(self, game).deliver
	end
	
	def send_reminder_text(game)
		phone = self.phone.gsub(/[\-\.]/, "").insert(0, '1')
		link = "http://alfieste.am/#{game.id}"
		sms = Moonshado::Sms.new(phone, "#{game.team.name} game at #{game.start_at.strftime('%l:%M%p')}. Reply with 'game #{game.id} (y or n)' or visit: #{link}")
		sms.deliver_sms
	end

end