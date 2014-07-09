PublicComics::Application.routes.draw do
  devise_for :user, :path => '', :path_names => { :sign_in => "sign_in", :sign_out => "sign_out", :sign_up => "sign_up" }
  resources :titles, only: [:index] do
    resources :issues, :name_prefix => "title_"
  end

  resources :issues, only: [:index] do
    resources :pages, :name_prefix => "issue_"
  end

  resources :genres, only: [:show]
  resources :pages, only: [:index, :show]


  root to: "welcome#index"

end



