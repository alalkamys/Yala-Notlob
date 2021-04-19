class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create
    candidate_friend = User.find_by email: params[:email]
    if candidate_friend
      if Friendship.create friend_id: candidate_friend.id, user_id: current_user.id
        flash[:info] = "#{candidate_friend.full_name} is added"
      else
        flash[:error] = "Unable to add friend"
      end
    else
      flash[:error] = "User doesn't exist"
    end
    redirect_to friends_path
  end

  def destroy
    @friend = Friendship.where(friend_id: params[:id])[0]
    @friend.destroy
    flash[:info] = "Friend Removed"
    redirect_to friends_path
  end
end
