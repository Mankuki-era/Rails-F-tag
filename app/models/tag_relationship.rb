class TagRelationship < ApplicationRecord
  # リレーション
  belongs_to :post
  belongs_to :tag

  # バリデーション
  validates :post_id, presence: true
  validates :tag_id, presence: true
end
