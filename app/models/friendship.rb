class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  # has_many :groups_users

  validates :user_id, uniqueness: { scope: :friend_id, message: "You already have this user as a friend" }
  validate :cannot_add_self

  after_destroy :remove_from_groups_if_exists

  private

  def cannot_add_self
    errors.add(:user_id, "You cannot add yourself as a friend.") if user_id == friend_id
  end

  def remove_from_groups_if_exists
    user_groups_ids = self.user.groups.map { |group| group.id }

    user_groups_ids.each do |group_id|
      group_participant_record = GroupParticipant.where(group_id: group_id).where(user_id: self.friend.id).first
      if group_participant_record
        group_participant_record.destroy
      end
    end
  end
end
