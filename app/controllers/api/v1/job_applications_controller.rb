class Api::V1::JobApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_workspace

  def index
    job_apps = @workspace.job_application.all
    options = { include: [:workspace]}
    render json: JobApplicationSerializer.new(job_apps).serializable_hash.to_json, status: :ok
  end

  def show
    job_app = @workspace.job_application.find(params[:id])
    render json: JobApplicationSerializer.new(job_app).serializable_hash.to_json, status: :ok
  end

  def create
    job_application = @workspace.job_application.create(job_application_params)

    if job_application.save
      render json: JobApplicationSerializer.new(job_application).serializable_hash.to_json, status: :created
    else
      render json: {
        message: job_application.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    job_application = @workspace.job_application.find(params[:id])
    if job_application.update(job_application_params)
      render json: JobApplicationSerializer.new(job_application).serializable_hash.to_json, status: :accepted
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

