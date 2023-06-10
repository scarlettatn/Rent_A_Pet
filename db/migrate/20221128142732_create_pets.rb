class CreateDesks < ActiveRecord::Migration[7.0]
  def change
    create_table :desks do |t|
      t.string :name
      t.string :species
      t.string :title
      t.text :description
      t.integer :price
      t.integer :age
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
