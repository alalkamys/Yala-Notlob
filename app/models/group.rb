class Group < ApplicationRecord
  # * Relationship with owner (One to Many)
  belongs_to :owner, class_name: "User"
  # * Relationship with members (Many to Many)
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: true
  validate :cannot_add_self, :members_uniqness, :friends_only

  private

  def cannot_add_self
    errors.add(:owner, "You cannot add yourself to your own group.") if user_ids[-1] == owner_id
  end

  def members_uniqness
    errors.add(:user, "You cannot repeat a member in a group.") unless user_ids.uniq == user_ids
  end

  def friends_only
    owner = User.find owner_id
    user_ids.each { |user_id|
      unless user_id == owner_id
        errors.add(:user, "#{User.find(user_id).full_name} is not in your friend list") unless owner.friend_with? user_id
      end
    }
  end
end
