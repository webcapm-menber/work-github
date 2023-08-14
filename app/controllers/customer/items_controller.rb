class Customer::ItemsController < ApplicationController
  
  before_action :set_params, only: %i[show]
  def index
    @items = Item.all.page(params[:page]).per(8)
  end

  def show
    @cart_item = CartItem.new
  end
  
  
  private
  
  def set_params
    @item = Item.find(params[:id])
  end
  
end
