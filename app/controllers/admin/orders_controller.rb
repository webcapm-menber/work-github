class Admin::OrdersController < ApplicationController
  
  before_action :authenticate_admin!
  
  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      redirect_to admin_order_path(order.id)
      flash[:notice] = "注文商品の更新に成功しました。"
    else
      flash[:notice] = "注文商品の更新に失敗しました。"
      render :show
    end
    
    order.order_details.update(production_status: 1) if order.status == "payment_confirmation"
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :payment, :postage, :address, :postal_code, :address_name, :status)
  end
end
