class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: %i[index create]

  def create
    @friend_request = current_user.friend_requests.new(friend_request_params)
    if @friend_request.save
      redirect_to users_path
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def destroy
    @friend_request.destroy
    redirect_to users_path
  end

  def update
    @friend_request.accept
    redirect_back(fallback_location: root_path)
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find_by(friend_id: params[:id])
  end

  def friend_request_params
    params.require(:friend_request).permit(:friend_id)
  end
end
