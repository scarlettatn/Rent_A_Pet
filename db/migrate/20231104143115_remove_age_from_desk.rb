class RemoveAgeFromDesk < ActiveRecord::Migration[7.0]
  def change
    remove_column :desks, :age, :integer
  end
end
