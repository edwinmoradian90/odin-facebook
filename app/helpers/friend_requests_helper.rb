module FriendRequestsHelper
  def friend_request_count
    @incoming = FriendRequest.where(friend: current_user)
    @incoming.count || 0
  end
end
