class GroupParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validate :members_uniqness, :friends_only

  def members_uniqness
    errors.add(:error, "#{User.find(user_id).full_name} already exists in your group.") if GroupParticipant.where(user_id: user_id, group_id: group_id).exists?
  end

  def friends_only
    owner = User.find Group.find(group_id).owner_id
    if owner.id == user_id
      errors.add(:error, "You can't add yourself to your group")
    else
      owner_friends_ids = owner.friends.map do |friend| friend.id end
      errors.add(:error, "#{User.find(user_id).full_name} is not in your friends list") unless owner_friends_ids.include? user_id
    end
  end
end
