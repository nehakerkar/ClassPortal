json.array!(@materials) do |material|
  json.extract! material, :id, :course_id, :user_id, :material
  json.url material_url(material, format: :json)
end
