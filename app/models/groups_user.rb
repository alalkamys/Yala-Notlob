class GroupsUser < ApplicationRecord

    # self.primary_key = [:user_id, :group_id]
    belongs_to :user
    belongs_to :group
end
