class RemoveIsShowFromDest < ActiveRecord::Migration
  def change
    remove_column :booking_hot_destinations, :is_show
  end
end
