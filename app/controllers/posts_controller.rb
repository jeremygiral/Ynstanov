class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy,:new,:like,:unlike, :search]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  respond_to :js , :json , :html
  def index
    @posts = Post.filter(params).order('posts.created_at DESC').page params[:page]
    respond_to do |format|
      format.html
      format.json { render :xml => @posts.to_xml }
    end
  end



  def show
  end



  def new
    @post = current_user.posts.build
  end

  def like
    if @post.liked_by current_user
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.js
        end
      end
  end

  def unlike
    if !(@post.liked_by current_user)
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.js
        end
      end
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end


  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed.  Please check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :category_id, tag_ids: []).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_tags
    @tags=Tag_post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
end
