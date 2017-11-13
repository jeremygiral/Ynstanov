class AddTagIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :tag, foreign_key: true
  end
end
