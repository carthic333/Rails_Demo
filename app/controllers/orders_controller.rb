class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.select{ |o| o.user_id ==  current_user.id }
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = "Order created Successfully"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def checkout
    order = Order.find(params[:id])
    order.update_attributes(status: 'checkout')
    redirect_to order_path(order)
  end
  
  def authorize
    Order.find(params[:id]).update_attributes(billing_address: params[:order][:billing_address], shipping_address: params[:order][:shipping_address])
    str = Order.find(params[:id]).authorize(params[:Credit_card])
    flash[:notice] = str
    redirect_to orders_path()
  end
  
  def cancel
    Order.find(params[:id]).update_attributes(status: 'cancelled')
    flash[:notice] = "Order Cancelled"
    redirect_to orders_path
  end
  private
  def order_params
    params.require(:order).permit(:shipping_address, :billing_address, :status)
  end
end
