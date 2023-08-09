class Customer::OrdersController < ApplicationController

  before_action :authenticate_customer!
  before_action :set_params, only: %i[show]

  def new
    @order = Order.new
  end

  def check
    @order = Order.new(order_params)
    @cart_item = current_customer.cart_items.all
    # byebug
    @total = @cart_item.inject(0) { |sum, item| sum + item.subtotal }  #商品合計金額の計算

    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.address_name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_address] == "1"
      @address = ShippingAddress.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.address_name = @address.address_name
    elsif params[:order][:select_address] == "2"

    else
      @order = Order.new
      render :new
      flash[:notice] = "再度ご確認の上、ご入力してください。"
    end
    @order.postage = 800
  end

  def completed
  end

  def create
    @order = current_customer.orders.new(order_params)
    # byebug
    if @order.save
      redirect_to orders_completed_path
    else
      # render :check, notice: "注文の確定に失敗しました。"
    end
  end

  def index
    @orders = Order.all
  end

  def show
  end

  private


  def set_params
    @order = Order.find(params[:id])
  end

  def order_params
    # params.require(:order).permit(:payment_method, :postal_code, :address, :address_name)
    params.require(:order).permit(:customer_id, :payment_method, :payment, :postage, :address, :postal_code, :address_name, :status)
  end

end
