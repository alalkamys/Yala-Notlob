class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create
    candidate_friend = User.find_by email: params[:email]
    # * user exists
    if candidate_friend
      candidate_friend_instance = Friendship.new friend_id: candidate_friend.id, user_id: current_user.id
      # * user is valid
      if candidate_friend_instance.save
        Notification.notify_invite()

        new_friend = {
          id: candidate_friend.id,
          full_name: candidate_friend.full_name,
          image: candidate_friend.get_image(),
          email: candidate_friend.email,
        }
        res = {
          success: true,
          new_friend: new_friend,
        }
        render json: res.to_json
      else
        res = {
          success: false,
          errors: candidate_friend_instance.errors[:user_id].first,
        }
        render json: res.to_json
      end
    else
      res = {
        success: false,
        errors: "User doesn't exist",
      }
      render json: res.to_json
    end
  end

  def destroy
    friend = User.find(params[:id])
    @friend_name = friend.full_name 
    @friend_id = params[:id]
    @friendship_record = Friendship.where(friend_id: params[:id], user_id: current_user.id).first
    @friendship_record.destroy
    respond_to do |format|
      format.js { render partial: "javascripts/friends/destroy_friend" }
    end
  end
end
