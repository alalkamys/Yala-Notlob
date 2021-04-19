class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create
    candidate_friend = User.find_by email: params[:email]
    if candidate_friend
      candidate_friend_instance = Friendship.new friend_id: candidate_friend.id, user_id: current_user.id
      if candidate_friend_instance.save
        flash[:info] = "#{candidate_friend.full_name} is added"
      else
        flash[:error] = candidate_friend_instance.errors[:user_id].first
      end
    else
      flash[:error] = "User doesn't exist"
    end
    redirect_to friends_path
  end

  def destroy
    @friend = Friendship.where(friend_id: params[:id], user_id: current_user.id).first
    @friend.destroy
    flash[:info] = "Friend Removed"
    redirect_to friends_path
  end
end
