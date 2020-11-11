class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :post_img
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships

  validates :title, presence: true
  validates :content, presence: true
end
