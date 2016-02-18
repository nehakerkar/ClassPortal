class CourseInstructor < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :course_students
  has_many :materials
  
  validates :course_id, :presence => true
  validates :user_id, :presence =>true
  validates :startdate, :presence => true
  validates :enddate, :presence => true
  validates :status, :presence => true
end
