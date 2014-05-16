PublicComics::Application.routes.draw do
  root to: 'welcome#index'

  resources :titles do
    resources :issues do
      resources :pages
    end
  end
  resources :issues
  resources :pages
  resources :genres
end
