# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :correct_user, only: :destroy

  def new
    @comment = Comment.new(post_id: params[:id])
  end

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post deleted.'
    redirect_to request.referrer || root_url
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(page: params[:page])
    @comment = current_user.comments.new
    @comment.post_id = @post.id
  end

  private

  def posts_params
    params.require(:post).permit(:content)
  end

  def correct_user
    @post = current_user.posts.find(params[:id])
    redirect_to root_url if @post.nil?
  end
end