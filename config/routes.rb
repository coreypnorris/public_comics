PublicComics::Application.routes.draw do
  root to: 'welcome#index'

  resources :titles, only: [:index] do
    resources :issues, only: [:index] do
      resources :pages, only: [:show]
    end
  end

  resources :genres, only: [:show]

end
