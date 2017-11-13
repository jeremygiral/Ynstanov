class TagPost < ApplicationRecord
  validates_uniqueness_of :tag_id, :scope => :post_id
  belongs_to :tag
  belongs_to :post
end
