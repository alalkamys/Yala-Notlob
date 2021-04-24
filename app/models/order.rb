class Order < ApplicationRecord
  # Relationship with User
  belongs_to :user

  # Relationship with order_member
  has_many :order_members

  # Relationship with invited member
  has_many :invited_members
  
  # Relationship with invited member
  has_many :notifications, dependent: :destroy
end
