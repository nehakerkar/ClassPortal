class CourseStudent < ActiveRecord::Base
  belongs_to :user
  belongs_to :course_instructor

  validates :course_instructor_id, :presence => true
  validates :user_id, :presence =>true
  validates :status, :presence => true
end
