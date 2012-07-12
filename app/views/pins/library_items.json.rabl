collection @pins
attributes :created_at, :updated_at, :status, :id

child :item do
  attributes :name, :url, :description
end
