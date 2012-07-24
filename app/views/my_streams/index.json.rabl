collection @streams
attributes :created_at, :updated_at, :name, :id

child :pins do
  attributes :created_at, :updated_at, :scheduled_at, :completed_at

  child :item do
    attributes :name, :url, :description
  end
end
