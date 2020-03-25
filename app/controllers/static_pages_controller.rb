class StaticPagesController < ApplicationController
  def home
    @user = current_user
    @post = current_user.posts.build
    @feed_items = Post.where(author_id: current_user.friends)
                      .or(Post.where(author_id: current_user.id))
  end
end
