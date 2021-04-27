class InvitedMember < ApplicationRecord
  belongs_to :order
  belongs_to :user 

  validate :cannot_add_self

  def invited?(id)
    self.where(user_id: id).exists?
  end

  # check if he is a friend or not
  def inFriend?(user_id)
    self.order.user.friends.where(id:user_id)
  end

  private
  def cannot_add_self
    errors.add(:user_id, " you cannot Invite yourself.") if user_id == order.user_id
  end
end
