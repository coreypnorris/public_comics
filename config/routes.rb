PublicComics::Application.routes.draw do
  devise_for :users
  resources :titles, only: [:index] do
    resources :issues, :name_prefix => "title_"
  end

  resources :issues, only: [:index] do
    resources :pages, :name_prefix => "issue_"
  end

  resources :genres, only: [:show]
  resources :pages, only: [:show]


  root to: "welcome#index"

end



