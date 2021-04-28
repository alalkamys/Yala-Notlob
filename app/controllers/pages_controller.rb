class PagesController < ApplicationController

  def home
    invited = InvitedMember.where(user_id: current_user.id)
    order = Order.where(invited_members: invited)
    @last_orders = order.sort_by &:created_at
    puts(order)
    puts('print')
    @last_orders.each do |order|
      puts('//////////////////////')
      puts(order.resturant_name)
      puts('//////////////////////')
    end
  end

end
