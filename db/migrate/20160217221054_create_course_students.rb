class CreateCourseStudents < ActiveRecord::Migration
  def change
    create_table :course_students do |t|
      t.references :user, index: true, foreign_key: true
      t.references :course_instructor, index: true, foreign_key: true
      t.string :grades
      t.string :status

      t.timestamps null: false
    end
    add_index :course_students, [:user_id, :course_instructor_id], :unique => true
  end
  
end
