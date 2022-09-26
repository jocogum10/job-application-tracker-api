class JobApplication < ApplicationRecord
  validates :title, presence: true

  belongs_to :workspace
end
