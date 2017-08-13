class CreateFishtripRooms < ActiveRecord::Migration
  def change
    create_table :fishtrip_rooms do |t|
      t.string :info
      t.integer :price
      t.timestamps null: false
    end
  end
end
