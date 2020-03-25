class CommentsController < ApplicationController
  before_action :set_comment, only: :destroy

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save!
      flash[:success] = 'Comment posted!'
      redirect_to post_path(@comment.post_id)
    else
      flash.now[:notice] = 'Comment could not save.'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment.destroy
    redirect_back(fallback_location: root_url)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :author_id)
  end

  def set_comment
    @comment = Comment.find_by(post_id: params[:post_id], author_id: current_user.id)
  end
end
