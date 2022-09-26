require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  subject { JobApplication.new }

  it "is invalid with missing user id" do
    subject.title = "Anything"
    subject.description = "Anything"
    subject.company = "Anything"
    subject.job_link = "Anything"
    subject.status = "Anything"
    subject.notes = "Anything"
    expect(subject).to_not be_valid
  end

  it "is valid when logged in" do
    user = User.create(email: 'test@example.com', password: 'password')
    workspace = user.workspaces.create(name: "workspace", description: "workspace description")

    subject.title = "Anything"
    subject.description = "Anything"
    subject.company = "Anything"
    subject.job_link = "Anything"
    subject.status = "Anything"
    subject.notes = "Anything"
    subject.workspace_id = workspace.id
    expect(subject).to be_valid
  end

  it "is invalid when name is empty" do
    user = User.create(email: 'test@example.com', password: 'password')
    workspace = user.workspaces.create(name: "workspace", description: "workspace description")

    subject.title = ""
    subject.description = "Anything"
    subject.company = "Anything"
    subject.job_link = "Anything"
    subject.status = "Anything"
    subject.notes = "Anything"
    subject.workspace_id = workspace.id
    expect(subject).to_not be_valid
  end
end
