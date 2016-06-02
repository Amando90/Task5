Rails.application.routes.draw do
  resources :posts do

  	resources :comments

  	collection do
  		post :import
  	end
  end

  resources :comments

  root 'posts#index'
end
