class Group < ApplicationRecord
  # * Relationship with owner (One to Many)
  belongs_to :owner, class_name: "User"
  # * Relationship with members (Many to Many)
  # has_many :users, :through => :groups_users
  # has_many :groups_users
  has_many :group_participants

  # has_many :groupsusers, class_name: "GroupsUser", dependent: :destroy

  validates :name, presence: true, uniqueness: true
  # validate :members_uniqness, :friends_only

  def members_uniqness
    errors.add(:user, "You cannot repeat a member in a group.") unless user_ids.uniq == user_ids
  end

  def friends_only
    owner = User.find owner_id
    user_ids.each { |user_id|
      if user_id == owner_id
        errors.add(:owner, "You cannot add yourself to your own group.")
      else
        user = User.find user_id
        errors.add(:user, "##{user.id} #{user.full_name} is not in your friend list") unless owner.friend_with? user_id
      end
    }
  end

  def group_member?(id_of_member)
    self.group_participants.where(user_id: id_of_member).exists?
  end
end
