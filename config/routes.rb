Rails.application.routes.draw do
  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout",
    registration: "signup"
  }, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  namespace :api do
    namespace :v1 do
      resources :workspaces do
        resources :memberships
      end
      resources :projects do
        resources :project_memberships
      end
    end
  end
end
