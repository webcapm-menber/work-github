class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @total_quantity = 0
  end

  def index
    @customer = Customer.find(params[:id])
    @orders = @customer.orders
    @total_quantity = 0
  end
end
