class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  validates :user_id, uniqueness: { scope: :friend_id, message: "You already have this user as a friend" }
  validate :cannot_add_self

  private

  def cannot_add_self
    errors.add(:user_id, "You cannot add yourself as a friend.") if user_id == friend_id
  end
end
