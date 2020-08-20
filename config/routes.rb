Rails.application.routes.draw do

  resources :category do
    resources :recipes

  end
end
