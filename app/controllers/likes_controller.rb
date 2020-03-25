# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_like, only: :destroy

  def create
    @like = current_user.likes.new(post_id: params[:id])
    if @like.save && !current_user.liked?(params[:id])
      flash[:success] = 'Like saved'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'Like not saved'
      redirect_to root_path
      puts 'doesnt work'
    end
  end

  def destroy
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_like
    @like = Like.find_by(post_id: params[:id], user_id: current_user.id)
  end
end
