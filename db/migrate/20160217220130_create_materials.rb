class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.references :course_instructor, index: true, foreign_key: true
      t.text :material

      t.timestamps null: false
    end
  end
end
