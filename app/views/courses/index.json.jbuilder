json.array!(@courses) do |course|
  json.extract! course, :id, :title, :coursenumber, :description
  json.url course_url(course, format: :json)
end
