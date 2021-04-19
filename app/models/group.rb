class Group < ApplicationRecord
    validates :name, presence:true, uniqueness:true
    belongs_to :owner ,class_name: "User"
    has_and_belongs_to_many :users

    validate :cannot_add_self
    validate :members_uniqness

    private

    def cannot_add_self
        errors.add(:owner, 'You cannot add yourself to your own group.') if user_ids[-1] == owner_id
    end

    def members_uniqness
        errors.add(:user, 'You cannot repeat a member in a group.') unless user_ids.uniq == user_ids
    end
end
