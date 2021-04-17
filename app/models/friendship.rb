class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: :User

    validates :user_id, uniqueness: { scope: :friend_id }
    validates :user_id, :exclusion => { :in => %w( :friend_id ) }
    
end
