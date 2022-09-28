require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Api::V1::Members", type: :request do

  before do
    @user = User.create(email: 'test@example.com', password: 'password')
    headers = {
      'Accept' => 'application/json', 
      'Content-Type' => 'application/json'
    }
    # This will add a valid token for `user` in the `Authorization` header
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, @user)
  end

  # index
  it "returns valid when accessing the members-data path" do
    get api_v1_member_data_path, headers: @auth_headers
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:data][:type]).to eq('user')
    expect(json[:data][:attributes][:email]).to eq(@user.email)
  end

end
