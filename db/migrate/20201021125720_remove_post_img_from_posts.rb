class RemovePostImgFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :post_img, :string
  end
end
