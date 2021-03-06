PublicComics::Application.routes.draw do
  devise_for :user, :path => '', :path_names => { :sign_in => "sign_in", :sign_out => "sign_out", :sign_up => "sign_up" }

  resources :titles, only: [:index, :show] do
    resources :issues
  end

  resources :issues do
    get "export"
    resources :pages
    resources :comments, only: [:create]
  end

  resources :comments do
    resources :comments, only: [:new, :create]
    resources :votes, only: [:new, :create]
  end

  resources :pages

  resources :genres, only: [:index, :show]

  resources :users, :path => 'profiles', only: [:show, :update]
  resources :users, :path => '', only: [:show] do
    resources :issues
  end

  root to: "welcome#index"

  match ":username", :to => "users#show", :via => :get

end
