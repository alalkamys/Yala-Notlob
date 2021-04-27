class Notification < ApplicationRecord
  belongs_to :receiver, :class_name => "User"
  belongs_to :order
  belongs_to :sender, :class_name => "User"

  enum notification_type: [:invitation, :acception]

  scope :unread, -> { where(read_at: nil) }
  scope :unviewed, -> { where(recieved: false) }

  # def self.notify_invite(invited_member)
  #   new_notification = Notification.new
  #   new_notification.receiver_id = invited_member.user_id
  #   new_notification.notification_type = 0
  #   new_notification.order_id = invited_member.order_id
  #   new_notification.sender_id = invited_member.order.user.id
  #   new_notification.viewed = false
  #   new_notification.save()
  #   data = {
  #     :notification_id => new_notification.id,
  #     :receiver => new_notification.receiver,
  #     :notification_type => new_notification.notification_type,
  #     :order => new_notification.order,
  #     :sender => new_notification.sender,
  #     :viewed => new_notification.viewed,
  #   }
  #   puts "=============Invitation Data==================="
  #   puts data
  #   puts "==============================================="

  #   ActionCable.server.broadcast("notification_channel_#{new_notification.receiver_id}", data)
  # end

  def self.notify_invite()
    new_notification = Notification.new
    new_notification.receiver_id = 2
    new_notification.notification_type = 0
    new_notification.order_id = 1
    new_notification.sender_id = 1
    new_notification.viewed = false
    new_notification.save()
    data = {
      :notification_id => new_notification.id,
      :receiver => new_notification.receiver,
      :notification_type => new_notification.notification_type,
      :order => new_notification.order,
      :sender => new_notification.sender,
      :viewed => new_notification.viewed,
    }
    puts "=============Invitation Data==================="
    puts data
    puts "==============================================="

    ActionCable.server.broadcast("notification_channel_#{new_notification.receiver_id}", data)
  end

  def self.notify_accept(accepted_order, user_who_accepted)
    new_notification = Notification.new
    new_notification.receiver_id = accepted_order.user.id
    new_notification.notification_type = 1
    new_notification.order_id = accepted_order.id
    new_notification.sender_id = user_who_accepted.id
    new_notification.viewed = false
    new_notification.save()
    data = {
      :notification_id => new_notification.id,
      :receiver => new_notification.receiver,
      :notification_type => new_notification.notification_type,
      :order => new_notification.order,
      :sender => new_notification.sender,
      :viewed => new_notification.viewed,
    }
    puts "=============Acceptance Data==================="
    puts data
    puts "==============================================="

    ActionCable.server.broadcast("notification_channel_#{new_notification.receiver_id}", data)
  end

  #   ActionCable.server.broadcast("notification_channel_#{new_notification.receiver_id}", data)
  # end
end
