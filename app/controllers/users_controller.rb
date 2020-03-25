class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def index
    @users = User.where.not(id: current_user.id).paginate(page: params[:page])
  end
end
