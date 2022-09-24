require 'rails_helper'

RSpec.describe Workspace, type: :model do

  subject { Workspace.new }

  it "is invalid with missing user id" do
    subject.name = "Anything"
    subject.description = "Anything"
    expect(subject).to_not be_valid
  end

  it "is valid when logged in" do
    user = User.create(email: 'test@example.com', password: 'password')

    subject.name = "Anything"
    subject.description = "Anything"
    subject.user_id = user.id
    expect(subject).to be_valid
  end

  it "is invalid when name is empty" do
    user = User.create(email: 'test@example.com', password: 'password')

    subject.name = ""
    subject.description = "Anything"
    subject.user_id = user.id
    expect(subject).to_not be_valid
  end
end
