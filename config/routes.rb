PublicComics::Application.routes.draw do
  devise_for :user, :path => '', :path_names => { :sign_in => "sign_in", :sign_out => "sign_out", :sign_up => "sign_up" }

  resources :titles, only: [:index] do
    resources :issues
  end

  resources :issues do
    resources :pages
    resources :comments, only: [:create]
  end

  resources :comments do
    resources :comments, only: [:new, :create]
    resources :votes, only: [:new, :create]
  end

  resources :genres, only: [:index, :show]
  resources :pages, only: [:index, :show]
  resources :users, :path => 'profiles', only: [:show, :update]

  root to: "welcome#index"

  match ":username", :to => "users#show", :via => :get

end
