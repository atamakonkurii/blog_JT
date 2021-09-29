Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update]
  get '/my_page' => 'users#my_page'

  root to: redirect("/#{I18n.default_locale}"), as: :redirected_root

  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    resources :posts, param: :slug
    root 'articles#index'
  end

  post 'articles/attach', to: 'articles#attach'
end
