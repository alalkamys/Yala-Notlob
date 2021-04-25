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
        Notification.notify_invite(1)
        new_friend = {
          id: candidate_friend.id,
          full_name: candidate_friend.full_name,
          image: candidate_friend.get_image(),
          email: candidate_friend.email
        }
        res = {
          new_friend: new_friend,
          succuess: true
        }
        render json: new_friend.to_json

      else
        flash[:error] = candidate_friend_instance.errors[:user_id].first
        res = {success: false,
               errors:  flash[:error]}
        render json: res.to_json
      end
    else
      flash[:error] = "User doesn't exist"
      res = {success: false}
      render json: res.to_json
    end
    # redirect_to friends_path
  end

  # TODO Need to remove friends if exists in the user groups
  def destroy
    @friend = Friendship.where(friend_id: params[:id], user_id: current_user.id).first
    @friend.destroy
    flash[:info] = "Friend Removed"
    redirect_to friends_path
  end
end
