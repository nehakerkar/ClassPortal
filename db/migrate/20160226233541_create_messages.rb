class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :senderid
      t.integer :recvid
      t.text :mesg

      t.timestamps null: false
    end
  end
end
