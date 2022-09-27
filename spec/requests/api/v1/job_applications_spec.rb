require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Api::V1::JobApplications", type: :request do

  before do
    @user = User.create(email: 'test@example.com', password: 'password')
    @workspace = @user.workspaces.create(name: "test name")
    @job_application = @workspace.job_application.create(title: "test name")
    headers = {
      'Accept' => 'application/json', 
      'Content-Type' => 'application/json'
    }
    # This will add a valid token for `user` in the `Authorization` header
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, @user)
  end

  # index
  it "returns invalid accessing the index and no valid token" do
    get api_v1_all_job_applications_path(@workspace.id)
    expect(response).to have_http_status(:unauthorized)
  end

  it "returns valid accessing the index and has valid token" do
    get api_v1_all_job_applications_path(@workspace.id), headers: @auth_headers
    expect(response).to have_http_status(:ok)
  end

  # show
  it "returns valid when having token and accessing the show" do
    get api_v1_show_job_application_path(@workspace.id, @job_application.id), headers: @auth_headers
    expect(response).to have_http_status(:ok)
  end

  # create
  it "returns valid when having token and creating new job application" do
    post api_v1_create_job_application_path(@workspace.id), params: {
      job_application: {
        title: "test name",
        description: "test",
        company: "test",
        job_link: "test",
        status: "test",
        notes: "test",
      }
    }, 
    headers: @auth_headers, as: :json
    expect(response).to have_http_status(:created)
  end

  # update
  it "return valid when having token and updating job application" do
    patch api_v1_update_job_application_path(@workspace.id, @job_application.id), params: {
      job_application: {
        title: "test name edited",
        description: "test edited",
        company: "test edited",
        job_link: "test edited",
        status: "test edited",
        notes: "test edited",
      }
    }, headers: @auth_headers, as: :json
    expect(response).to have_http_status(:accepted)
  end

  # destroy
  it "return no content when successfully deleting a job application" do
    delete api_v1_destroy_job_application_path(@workspace.id, @job_application.id), headers: @auth_headers
    expect(response).to have_http_status(:no_content)
  end
end
