class WorkspaceSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :updated_at
  belongs_to :user
end
