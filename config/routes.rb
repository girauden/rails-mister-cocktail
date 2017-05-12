Rails.application.routes.draw do
  root "cocktails#index"
  mount Attachinary::Engine => "/attachinary"
  resources :cocktails,  only: [:show, :new, :create] do
    resources :doses, only: [:new, :create, :destroy], shallow: true
  end
end
