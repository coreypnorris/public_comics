PublicComics::Application.routes.draw do
  resources :titles, only: [:index] do
    resources :issues, :name_prefix => "title_"
  end

  resources :issues, only: [:index] do
    resources :pages, :name_prefix => "issue_"
  end

  resources :pages, only: [:show]

  resources :genres, only: [:show]

  root to: 'welcome#index'
end



