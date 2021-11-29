Rails.application.routes.draw do
  namespace "api" do
    resources :users
    resources :posts
    resources :favorites
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
