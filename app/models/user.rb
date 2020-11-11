class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_img

  has_many :following_relationships, foreign_key: "follower_id", class_name: "FollowRelationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "FollowRelationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  validates :user_name, presence: true

  #すでにフォロー済みであればtrue返す
  def following?(other_user)
    self.followings.include?(other_user)
  end

  #ユーザーをフォローする
  def follow(other_user)
    unless self == other_user
      self.following_relationships.find_or_create_by(following_id: other_user.id)
    end
  end

  #ユーザーのフォローを解除する
  def unfollow(other_user)
    @following_relationships = self.following_relationships.find_by(following_id: other_user.id)
    @following_relationships.destroy if @following_relationships
  end

  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end
end
