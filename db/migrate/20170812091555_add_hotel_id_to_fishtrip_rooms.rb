class AddHotelIdToFishtripRooms < ActiveRecord::Migration
  def change
    add_column :fishtrip_rooms, :hotel_id, :integer
  end
end
