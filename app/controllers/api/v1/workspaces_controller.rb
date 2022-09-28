class Api::V1::WorkspacesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_workspace, only: %i[show update destroy]

  def index
    workspaces = current_user.workspaces.all
    options = { include: [:user]}
    render json: WorkspaceSerializer.new(workspaces, options).serializable_hash.to_json, status: :ok
  end

  def show
    render json: WorkspaceSerializer.new(@workspace).serializable_hash.to_json, status: :ok
  end

  def create
    workspace = current_user.workspaces.create(workspace_params)

    if workspace.save
      render json: WorkspaceSerializer.new(workspace).serializable_hash.to_json, status: :created
    else
      render json: {
        message: workspace.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    if @workspace.update(workspace_params)
      render json: WorkspaceSerializer.new(@workspace).serializable_hash.to_json, status: :accepted
    else
      render json: {
        message: @workspace.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @workspace.destroy
      render json: {},status: :no_content
    else
      render json: {
        message: @workspace.errors
      }, status: :unprocessable_entity
    end
  end

  private

  def get_workspace
    @workspace = current_user.workspaces.find(params[:id])
  end

  def workspace_params
    params.require(:workspace).permit(:name, :description)
  end
end
