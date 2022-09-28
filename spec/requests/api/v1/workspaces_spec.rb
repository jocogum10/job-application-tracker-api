require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Api::V1::Workspaces", type: :request do

  before do
    @user = User.create(email: 'test@example.com', password: 'password')
    @workspace = @user.workspaces.create(name: "test name")
    headers = {
      'Accept' => 'application/json', 
      'Content-Type' => 'application/json'
    }
    # This will add a valid token for `user` in the `Authorization` header
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, @user)
  end

  # index
  it "returns invalid when does not have token and accessing the index" do
    get '/api/v1/workspaces'
    expect(response).to have_http_status(:unauthorized)
  end

  it "returns valid when having token and accessing the index" do
    get '/api/v1/workspaces', headers: @auth_headers
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:data][0][:type]).to eq('workspace')
    expect(json[:data][0][:attributes][:name]).to eq(@workspace.name)
    expect(json[:data][0][:relationships][:user][:data][:id]).to eq(@user.id.to_s)
  end

  # show
  it "returns valid when having token and accessing the show" do
    get api_v1_show_workspace_path(@workspace.id), headers: @auth_headers
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:data][:type]).to eq('workspace')
    expect(json[:data][:attributes][:name]).to eq(@workspace.name)
  end

  # create
  it "returns valid when having token and creating new workspace" do
    post '/api/v1/workspaces', params: {
      workspace: {
        name: "test name",
        description: "test",
      }
    }, 
    headers: @auth_headers, as: :json
    expect(response).to have_http_status(:created)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:data][:type]).to eq('workspace')
    expect(json[:data][:attributes][:name]).to eq("test name")
  end

  # update
  it "return valid when having token and updating workspace" do
    patch api_v1_update_workspace_path(@workspace.id), params: {
      workspace: {
        name: "test name edited",
        description: "test edited",
      }
    }, headers: @auth_headers, as: :json
    expect(response).to have_http_status(:accepted)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:data][:type]).to eq('workspace')
    expect(json[:data][:attributes][:name]).to eq("test name edited")
  end

  # destroy
  it "return no content when successfully deleting a workspace" do
    delete api_v1_destroy_workspace_path(@workspace.id), headers: @auth_headers
    expect(response).to have_http_status(:no_content)
  end
end
