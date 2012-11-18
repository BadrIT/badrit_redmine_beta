Rails.application.routes.draw do

  # Exception Logger
  resources :logged_exceptions do
    collection do
      post :query
      get :query
      post :destroy_all
      get :feed
    end
  end
end