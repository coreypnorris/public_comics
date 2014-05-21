PublicComics::Application.routes.draw do


  resources :titles, only: [:index] do
    resources :issues, only: [:index] do
      resources :pages, only: [:show]
    end
  end

  resources :genres, only: [:show]
  root to: 'welcome#index'
end
