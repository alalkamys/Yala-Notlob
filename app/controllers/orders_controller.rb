class OrdersController < ApplicationController
  def index
    # @orders = Order.where(user_id: current_user.id)
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @Items = OrderMember.joins(:order)
  end

  def new
    @order = Order.new
    @friends = Friendship.where(user_id: current_user.id)
  end

  def create
    @order = Order.new(order_params)
    @friends = Friendship.where(user_id: current_user.id)
    if @order.save
      redirect_to @order
    else
      render :new
    end
  end

  def finish
    @order = Order.find(params[:id])
    @Items = OrderMember.joins(:order)
  end

  def cancel
    @order = Order.find(params[:id])
    @Items = OrderMember.joins(:order)
  end

  private
    def order_params
      params.require(:order).permit(:mealtype, :resturant_name, :menu_img).merge(user: current_user)
    end
end
