require "rails_helper"

describe "sign up for users", :type => :request do
  before do 
      post '/users' , params: {
      email: "test1@test.com",
      password: "password",
      confirmation_password: "password"
    }
  end
  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns a message for successful sign up' do
    expect(JSON.parse(response.body)['message']).to eq('Signed up successfully.')
  end
end