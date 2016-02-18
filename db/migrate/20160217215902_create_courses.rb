class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :coursenumber, unique: true
      t.text :description

      t.timestamps null: false
    end
  end
end
