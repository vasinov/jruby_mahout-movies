Movies::Application.routes.draw do
  devise_for :users, :path => "", :path_names => { :sign_in => 'sign_in',
                                                   :sign_out => 'sign_out'}

  root :to => "home#index"

  resources :movies do
    member do
      post 'rate/:rating', :action => 'rate', :as => "rate"
    end
  end

  match 'profile' => 'users#profile', :via => :get
end
