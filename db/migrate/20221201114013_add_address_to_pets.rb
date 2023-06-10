class AddAddressToDesks < ActiveRecord::Migration[7.0]
  def change
    add_column :desks, :address, :string
  end
end
