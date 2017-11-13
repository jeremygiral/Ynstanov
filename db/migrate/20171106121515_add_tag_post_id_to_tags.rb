class AddTagPostIdToTags < ActiveRecord::Migration[5.1]
  def change
    add_reference :tags, :tag_post, foreign_key: true
  end
end
