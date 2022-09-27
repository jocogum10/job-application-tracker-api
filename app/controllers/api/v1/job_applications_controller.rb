class Api::V1::JobApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_workspace

  def index
    render json: {
      job_applications: @workspace.job_application.all
    }, status: :ok
  end

  def show
    render json: {
      job_application: @workspace.job_application.find(params[:id])
    }, status: :ok
  end

  def create
    job_application = @workspace.job_application.create(job_application_params)

    if job_application.save
      render json: {
        job_application: job_application,
        message: "Successfully created a job application.",
      }, status: :created
    else
      render json: {
        message: job_application.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    job_application = @workspace.job_application.find(params[:id])
    if job_application.update(job_application_params)
      render json: {
        job_application: job_application,
        message: "Successfully updated the workspace."
      }, status: :accepted
    else
      render json: {
        message: job_application.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    job_application = @workspace.job_application.find(params[:id])
    if job_application.destroy
      render json: {},status: :no_content
    else
      render json: {
        message: job_application.errors
      }, status: :unprocessable_entity
    end
  end

  private

  def get_workspace
    @workspace = current_user.workspaces.find(params[:workspace_id])
  end

  def job_application_params
    params.require(:job_application).permit(:title, :description, :company, :job_link, :status, :notes)
  end

end

