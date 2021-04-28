require 'active_record/errors'
class OrdersController < ApplicationController

  def index
    # @orders = Order.where(user_id: current_user.id)
    @orders = Order.all
  end

  def show
    begin
      @order = Order.find(params[:id])
      @Items = OrderMember.where(order: @order)
      @invited = InvitedMember.where(order_id: @order.id).count
      @joind = InvitedMember.where(joind: true).where(order_id: @order.id).count
    rescue => e 
      raise AbstractController::ActionNotFound.new("Sorry this order is deleted")
    end 
  end

  def new
    @order = Order.new
    InvitedUsers.clear()
    @friends_to_invite = InvitedUsers.get()
  end

  def create
    @order = Order.new(order_params)
    friends_to_invite = InvitedUsers.get()
    if @order.save
      friends_to_invite.each do |user|
        userModel = User.find(user.id)
        invitedMember = InvitedMember.create(order: @order, user: userModel, joind: false)
        Notification.notify_invite(invitedMember)
      end
      redirect_to @order
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.status = "Finish"
    @order.save
    respond_to do |format|
      format.js { render partial: "javascripts/orders/finish_order" }
    end
  end
  
  def search
    if params[:user].present?
      # @group = current_user.groups.find(params[:group_id])
      @members = current_user.search(params[:user])
      puts(current_user.groups)
      puts("------------------------------user group--------------------------")
      @group = current_user.groups.where(name: params[:user]).limit(1)
      puts(@group)
      puts("------------------------------chossen group--------------------------")
      if @group != []
        @members = @group[0].group_participants.all.map { |group_participant| group_participant.user }
        if @members
          puts("---------------render groups--------------------")
          respond_to do |format|
            format.js { render partial: "javascripts/orders/search_result" }
          end
        end  
      elsif @members != []
        puts(@members)
        puts("---------------render members--------------------")
        respond_to do |format|
          format.js { render partial: "javascripts/orders/search_result" }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "User is not in your friendlist"
          format.js { render partial: "javascripts/orders/search_result" }
        end
      end
    else
      respond_to do |format|
        @group = current_user.groups.find(params[:group_id])
        @members = []
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: "javascripts/orders/search_result" }
      end
    end
  end

  def addToInvitedList
    if params[:user].present?
      InvitedUsers.add(User.find(params[:user]))
      puts(InvitedUsers.get())
      @friends_to_invite = InvitedUsers.get()
      render partial: "javascripts/orders/invitation_list"
    end
  end

  def removeFromInvitedList
    if params[:user].present?
      InvitedUsers.delete(User.find(params[:user]))
      puts(InvitedUsers.get())
      @friends_to_invite = InvitedUsers.get()
      render partial: "javascripts/orders/invitation_list"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.js { render partial: "javascripts/orders/cancel_order" }
    end
  end

  def order_Invited
    @order = Order.find(params[:order_id])
    @invited_users = InvitedMember.where(order_id: @order.id).where(joind: false)
  end

  def order_Joined
    @order = Order.find(params[:order_id])
    @joined_users = InvitedMember.where(order_id: @order.id).where(joind: true)
  end

  def remove_Invited
    @id = params[:invited_id] 
    invited_member = InvitedMember.find(@id)
    invited_member.destroy
    respond_to do |format|
      format.js { render partial: "javascripts/orders/remove_user" }
    end
  end

  def remove_Joined
    @order = Order.find(params[:order_id])
    @id = params[:invited_id] 
    invited_member = InvitedMember.find(@id)
    invited_member.destroy
    order_member = @order.order_members.where(user_id: invited_member.user_id)
    order_member.each do |item|
      item.destroy
    end
    respond_to do |format|
      format.js { render partial: "javascripts/orders/remove_user" }
    end
  end

  def joinOrder
    puts(params)
    @user = User.find(params[:user])
    @order = Order.find(params[:order])
    notification = Notification.find(params[:notification_id])
    invitedMember = InvitedMember.find_by(user: @user, order: @order)
    puts(invitedMember)
    notification.destroy
    if @order.status != "Active"
      raise AbstractController::ActionNotFound.new('Sorry this order is finished!')
    end
    if invitedMember == nil
      raise AbstractController::ActionNotFound.new('Sorry you are no longer invited to this order or this order is deleted!')
    end
    if invitedMember != nil and @order.status == "Active"
      invitedMember.update(joind: true)
      Notification.notify_accept(@order, @user)
    end
    redirect_to @order
  end

  def cancelInvitaion
    puts(params)
    @user = User.find(params[:user])
    @order = Order.find(params[:order])
    notification = Notification.find(params[:notification_id])
    invitedMember = InvitedMember.find_by(user: @user, order: @order)
    puts(invitedMember)
    if invitedMember != nil
      invitedMember.destroy
    end
    notification.destroy
    redirect_to "/orders"
  end

  private
    def order_params
      params.require(:order).permit(:mealtype, :resturant_name, :menu_img, :option, :joined_id, :invited_id).merge(user: current_user)
    end
end