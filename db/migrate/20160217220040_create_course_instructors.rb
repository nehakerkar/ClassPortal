class CreateCourseInstructors < ActiveRecord::Migration
  def change
    create_table :course_instructors do |t|
      t.references :user, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.timestamp :startdate
      t.timestamp :enddate
      t.string :status

      t.timestamps null: false
    end
   # add_index :course_instructors, [:user_id, :course_id, :startdate, :enddate], :unique => true
  end
  
end
