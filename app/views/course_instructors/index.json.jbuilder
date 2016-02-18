json.array!(@course_instructors) do |course_instructor|
  json.extract! course_instructor, :id, :user_id, :course_id, :startdate, :enddate, :status
  json.url course_instructor_url(course_instructor, format: :json)
end
