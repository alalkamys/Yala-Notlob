class Notification < ApplicationRecord
  belongs_to :receiver, :class_name => "User"
  belongs_to :order
  belongs_to :sender, :class_name => "User"
end
