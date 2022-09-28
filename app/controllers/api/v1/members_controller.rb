class Api::V1::MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = get_user_from_token
    options = { include: [:workspaces] }
    render json: UserSerializer.new(user).serializable_hash.to_json, status: :ok
  end

  private

  def get_user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV['DEVISE_JWT_SECRET_KEY']).first
    user_id = jwt_payload['sub']
    User.find(user_id.to_s)
  end
end