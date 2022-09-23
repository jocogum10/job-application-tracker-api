require 'rails_helper'

RSpec.describe Workspace, type: :model do

  subject { Workspace.new }

  it "is invalid with missing user id" do
    subject.name = "Anything"
    subject.description = "Anything"
    expect(subject).to_not be_valid
  end
end
