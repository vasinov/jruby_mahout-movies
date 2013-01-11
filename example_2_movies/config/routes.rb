Movies::Application.routes.draw do
  devise_for :users, :path => "", :path_names => { :sign_in => 'sign_in',
                                                   :sign_out => 'sign_out'}

  root :to => "home#index"

  resources :movies

  match 'profile' => 'users#profile', :via => :get
end
