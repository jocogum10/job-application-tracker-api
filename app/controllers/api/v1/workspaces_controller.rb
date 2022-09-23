class Api::V1::WorkspacesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_workspace, only: %i[show update]

  def index
    render json: current_user.workspaces
  end

  def show
    render json: @workspace
  end

  def create
    workspace = current_user.workspaces.create(workspace_params)

    if workspace.save
      render json: {
        workspace,
        message: "Successfully created a new workspace.",
      }, status: :created
    else
      render json: {
        message: workspace.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    if @workspace.update(workspace_params)
      render json: @workspace
    else
      render json: {
        message: @product.errors
      }, status: :unprocessable_entity
  end

  def destroy
    render json: {
      message: "Deleted a new workspace."
    }, status: :ok
  end

  private

  def get_workspace
    @workspace = current_user.workspace.find(params[:id])
  end

  def workspace_params
    params.require(:workspace).permit(:name, :description)
  end
end
