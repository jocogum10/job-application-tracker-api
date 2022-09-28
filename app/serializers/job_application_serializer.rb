class JobApplicationSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :company, :job_link, :status, :notes
  belongs_to :workspace
end
