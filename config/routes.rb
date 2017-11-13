Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'posts#index'

  #localized do
  devise_for :users, :controllers => { registrations: 'registrations' }
  #resources :posts
  #resources :profiles
  get '/profiles/:slug', to: 'profiles#show', as: 'profiles'
  get '/tag/:tag_id', to: 'posts#index', as: 'post_tag_filter'
  get '/category/:category_id', to: 'posts#index', as: 'post_cat_filter'


  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end

end
