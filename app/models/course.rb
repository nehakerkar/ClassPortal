class Course < ActiveRecord::Base
 has_many :course_instructors
 
 validates :coursenumber, :presence => true
 validates :title, :presence => true
 validates_uniqueness_of :coursenumber, :message =>'This Coursenumber already exists'
end
