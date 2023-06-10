class RenameColumnsInBookmarks < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookmarks, :pet_id, :desk_id
  end
end
