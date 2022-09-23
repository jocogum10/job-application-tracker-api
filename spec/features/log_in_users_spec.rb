require "rails_helper"

describe "log in for users", :type => :request do
  before do 
      post '/users/sign_in' , params: {
      email: "test1@test.com",
      password: "password"
    }
  end
  it 'returns invalid login' do
    expect(response).to have_http_status(:unauthorized)
  end
end