Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "profile", to: "users#profile"
  resources :games do
    get "blackjack", to: "pages#blackjack"
    post "blackjack", to: "pages#blackjack"
    get "poker", to: "pages#poker"
    get "roulette", to: "pages#roulette"
  end
end
