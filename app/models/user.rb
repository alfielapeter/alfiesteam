class User < ActiveRecord::Base
	has_many :games_users, :dependent => :destroy
	has_many :teams_users, :dependent => :destroy
	has_many :teams, :through => :teams_users
	has_many :games, :through => :games_users
	
  devise :database_authenticatable, :registerable, :recoverable, 
				 :rememberable, :trackable, :validatable, :invitable

	validates_presence_of :name, :message => "can't be blank."
	validates_presence_of :phone, :message => "number can't be blank.", :if => :invited_or_captain
	validates_length_of 	:phone, :is => 10, :message => "number must be 10 digits.", :if => :invited_or_captain
	validates_format_of 	:phone, :with => /^[\d]+$/, :message => "number is invalid. Just enter digits, no spaces or dashes", :if => :invited_or_captain
	validates_uniqueness_of :phone, :message => "number is already taken. Have you already signed up? If so, try logging in or contacting support if you are having trouble."
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :phone, :captain, :time_zone

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

# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  invitation_token     :string(20)
#  invitation_sent_at   :datetime
#  name                 :string(255)
#  phone                :string(255)
#  captain              :boolean         default(FALSE)
#  created_at           :datetime
#  updated_at           :datetime
#  time_zone            :string(255)
#

