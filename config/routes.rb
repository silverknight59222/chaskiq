Rails.application.routes.draw do
  devise_for :users

  resources :apps do
    member do
      post :search
    end
    resources :app_users
    resources :segments
  end

  get "/apps/:app_id/segments/:id/:jwt.:jwt2", to: 'segments#show'

  root :to => "home#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "tester" => 'client_tester#show'


  scope path: '/api' do
    scope path: '/v1' do
      resources :apps, controller: "api/v1/apps" do
        member do 
          post :ping
        end
      end
    end
  end

end
