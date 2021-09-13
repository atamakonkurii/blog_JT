Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update]
  get '/mypage' => 'users#mypage'

  root 'articles#index'

  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    resources :posts, param: :slug
  end

  post 'articles/attach', to: 'articles#attach'
end
