Factory.define :user do |f|
  f.sequence(:email) {|n| "person#{n}@example.com" }
	f.name "User"
	f.phone "208-867-5309"
	f.password "secret"
	f.password_confirmation {|u| u.password}
	f.reset_password_token nil
	
end

Factory.define :team do |f|
	f.name "Big Duke"
	f.league "M2"
	f.location "Boise"
end
	
Factory.define :game do |f|
	f.start_at Time.now
end

Factory.define :games_user do |f|
	f.association :game
	f.association :user
end