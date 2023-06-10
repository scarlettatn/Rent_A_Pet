class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :desk

  validates :user_id, presence: true
  validates :desk_id, presence: true
end
