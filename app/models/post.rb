class Post < ApplicationRecord
  acts_as_votable
  validates :user_id, presence: true
  has_attached_file :image, styles: { medium: "500x500", thumb: "100x100>"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  belongs_to :user, dependent: :destroy
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts

  def self.search_by_user(slug)
    Post.where(['user_id = ?', slug.to_i])
  end

  # def score
  #   self.get_upvotes.size - self.get_downvotes.size
  # end

  def self.filter(params)
    if params[:category_id]
      Post.where(["category_id=?", params[:category_id]]).order(updated_at: :desc,created_at: :desc)
    elsif params[:tag_id]
      Post.joins(:tag_posts).where(['tag_id = ?', params[:tag_id]]).order(updated_at: :desc,created_at: :desc)
    elsif params[:keywords]
      Post.joins("LEFT JOIN CATEGORIES on POSTS.CATEGORY_ID=CATEGORIES.ID LEFT JOIN TAG_POSTS ON POSTS.ID=TAG_POSTS.POST_ID LEFT JOIN TAGS ON TAG_POSTS.TAG_ID=TAGS.ID LEFT JOIN USERS ON POSTS.USER_ID=USERS.ID").where("categories.name LIKE :query",query: "%#{params[:keywords]}%").or(Post.joins("LEFT JOIN CATEGORIES on POSTS.CATEGORY_ID=CATEGORIES.ID LEFT JOIN TAG_POSTS ON POSTS.ID=TAG_POSTS.POST_ID LEFT JOIN TAGS ON TAG_POSTS.TAG_ID=TAGS.ID LEFT JOIN USERS ON POSTS.USER_ID=USERS.ID").where("users.pseudo LIKE :query",query: "%#{params[:keywords]}%")).or(Post.joins("LEFT JOIN CATEGORIES on POSTS.CATEGORY_ID=CATEGORIES.ID LEFT JOIN TAG_POSTS ON POSTS.ID=TAG_POSTS.POST_ID LEFT JOIN TAGS ON TAG_POSTS.TAG_ID=TAGS.ID LEFT JOIN USERS ON POSTS.USER_ID=USERS.ID").where("case when :query like '%#%' then CAST('#'||tags.name as varchar) LIKE :query else 1=0 end",query: "%#{params[:keywords]}%")).order(updated_at: :desc,created_at: :desc)
    else
      Post.all.order(updated_at: :desc,created_at: :desc)
    end
  end


end
