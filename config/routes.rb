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
      post '/workspaces', to: 'workspaces#create', as: "create_workspace"
      patch '/workspaces/:id', to: 'workspaces#update', as: "update_workspace"
      delete '/workspaces/:id', to: 'workspaces#destroy', as: "destroy_workspace"

      get '/workspaces/:workspace_id/job-applications', to: "job_applications#index", as: "all_job_applications"
      get '/workspaces/:workspace_id/job-applications/:id', to: 'job_applications#show', as: "show_job_application"
      post '/workspaces/:workspace_id/job-applications', to: 'job_applications#create', as: "create_job_application"
      patch '/workspaces/:workspace_id/job-applications/:id', to: 'job_applications#update', as: "update_job_application"
      delete '/workspaces/:workspace_id/job-applications/:id', to: 'job_applications#destroy', as: "destroy_job_application"
    end
  end
end
