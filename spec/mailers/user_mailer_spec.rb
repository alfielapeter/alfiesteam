# Doing something wrong here. Not sure what, but can't seem to get it to accept instance variables and pass them through

require "spec_helper"

describe UserMailer do
	
  describe "game_reminder" do
		
		before do
			@game = Factory(:game)
			@player = Factory(:user)	
		end
    
		#let(:mail) { UserMailer.game_reminder(@player, @game) }

    it "renders the headers" 
      #mail.subject.should eq(@team.name)
      #mail.to.should eq(["#{@player.name}<#{@player.email}>"])
      #mail.from.should eq(["#{@captain.name}<#{@captain.email}>"])
    

    it "renders the body" 
       #mail.body.encoded.should match("Hi")
    
  end

end
