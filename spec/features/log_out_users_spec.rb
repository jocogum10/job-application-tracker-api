require "rails_helper"

describe "log out for users", :type => :request do
  before do 
      delete '/users/sign_out'
  end
  it 'returns invalid login' do
    expect(response).to have_http_status(:ok)
  end
end