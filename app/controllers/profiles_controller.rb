class ProfilesController < ApplicationController
  #before_action :authenticate_user!
  def show
    @posts = Post.search_by_user(params[:slug]).order('created_at DESC').page params[:page]
  end

end
