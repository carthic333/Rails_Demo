class LineItemsController < ApplicationController
  def delete
    order = LineItem.find(params[:id]).remove
    redirect_to order_path(order)
  end
  
  def update_quantity
    order = LineItem.find(params[:id]).update_quantity(params[:line_item]["qty"].to_i)
    redirect_to order_path(order)
  end

  private
  def lineitem_params
    params.require(:lineitem).permit(:unit_price, :quantity, :tax, :total)
  end
end
