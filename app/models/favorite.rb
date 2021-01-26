class Favorite < ApplicationRecord
  # リレーション
  belongs_to :user
  belongs_to :post

  # バリデーション
  validates_uniqueness_of :post_id, scope: :user_id
end
