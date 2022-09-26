class Workspace < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :job_application, dependent: :destroy
end
