class RemoveSpeciesFromDesk < ActiveRecord::Migration[7.0]
  def change
    remove_column :desks, :species, :string
  end
end
