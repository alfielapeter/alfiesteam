Alfiesteam::Application.routes.draw do
  post "sms/index"

  resources :games do
    member do
      post 'attending'
      post 'not_attending'
    end
  end

  resources :teams do
    collection do
      post 'change_team'
    end
    member do
      post 'remove_player'
      get 'resend_invitation'
    end
  end

  devise_for :users, :controllers => { :sessions => "users/sessions", :invitations => "users/invitations" }

  match '/about' => 'pages#about'
  match '/faq' => 'pages#faq'

  match ':id' => 'games#show'

  root :to => "pages#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.
end
