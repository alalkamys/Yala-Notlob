class OrderMembersController < ApplicationController

  def index
    @orders_members = OrderMember.where(user_id: current_user.id)
  end

  def show
  end

  def new
  end

  def create
    @order = Order.find(params[:order_id])
    @order_members = @order.order_members.create(order_members_params)
    puts(params)
    puts("--------------------------------------------------------------")

    # @order_members = @order.order_members.create(item: params[:order_member][:item], amount: params[:order_member][:amount], price: params[:order_member][:price], comment: params[:order_member][:comment], user: current_user)
    respond_to do |format|
      format.js { render partial: "javascripts/order_members/create_order_member" }
    end
  end

  def destroy
    @order = Order.find(params[:order_id])
    @order_members = @order.order_members.find(params[:id])
    @order_members.destroy
    puts(params)
    respond_to do |format|
      format.js { render partial: "javascripts/orders/destroy_order_member" }
    end
  end
  private
    def order_members_params
      params.require(:order_member).permit(:item, :amount, :price, :comment).merge(user: current_user)
    end
end
