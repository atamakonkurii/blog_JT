Rails.application.routes.draw do
  root 'articles#index'

  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    resources :posts, param: :slug
  end
end
