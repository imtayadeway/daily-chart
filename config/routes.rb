Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
             controller: "clearance/passwords",
             only: [:create, :edit, :update]
  end

  resource :chart, only: [:new, :create, :edit, :update]
  resource :dashboard, only: :show
  resources :submissions, only: [:new, :create]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  root 'welcome#index'
end
