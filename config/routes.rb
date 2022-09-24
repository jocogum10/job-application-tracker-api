Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/member-data', to: 'members#show'

      get '/workspaces', to: 'workspaces#index', as: "all_workspaces"
      get '/workspaces/:id', to: 'workspaces#show', as: "show_workspace"
      post '/workspaces/:id', to: 'workspaces#create', as: "create_workspace"
      delete '/workspaces/:id', to: 'workspaces#destroy', as: "destroy_workspace"
    end
  end
end
