class Api::V1::JobApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      job_applications: Workspaces.all,
    }, status: :ok
  end

end
