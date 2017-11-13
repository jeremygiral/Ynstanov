class AddTagPostIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :tag_post, foreign_key: true
  end
end
