class RenameColumnsInBookings < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookings, :pet_id, :desk_id
  end
end
