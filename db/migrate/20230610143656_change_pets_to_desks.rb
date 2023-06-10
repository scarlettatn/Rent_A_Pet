class ChangePetsToDesks < ActiveRecord::Migration[7.0]
  def change
    rename_table :pets, :desks
  end
end
