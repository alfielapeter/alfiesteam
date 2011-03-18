Factory.define :user do |f|
  f.sequence(:email) {|n| "person#{n}@example.com" }
	f.name "User"
	f.sequence(:phone) {|p| "208867530#{p}"}
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