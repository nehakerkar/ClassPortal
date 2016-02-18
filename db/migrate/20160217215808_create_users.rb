class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :password_digest
      t.string :name
      t.string :type
      t.boolean :deleteable

      t.timestamps null: false
    end
  end
end
