require "rails_helper"

describe "log in for users", :type => :request do

  before do
    post "/users", params: {
      email: "test1@test.com", 
      password: "password",
      confirmation_password: "password"
    }
  end

  it 'returns valid login' do
    post "/users/sign_in", params: { 
      email: "test1@test.com", 
      password: "password"
    }, headers: {
      'Accept' => 'application/json', 
      'Content-Type' => 'application/json'
    }, as: :json
    expect(response).to have_http_status(:ok)
  end
end