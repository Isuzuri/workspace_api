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
        resources :memberships, only: [] do
          collection do
            post :invite
            delete :exclude
            patch :change_role
          end
        end
      end
    end
  end
end
