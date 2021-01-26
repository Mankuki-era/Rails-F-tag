class Tag < ApplicationRecord
  # リレーション
  has_many   :tag_relationships, dependent: :destroy
  has_many   :posts, through: :tag_relationships

  # バリデーション
  validates :name, uniqueness: true
end