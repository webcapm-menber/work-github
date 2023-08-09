class Customer::ItemsController < ApplicationController
  
  before_action :set_params, only: %i[show create]
  def index
    @items = Item.all
  end

  def show
    @cart_item = CartItem.new
  end
  
  def create
    if @item.save
      
    end
  end
  
  
  private
  
  def set_params
    @item = Item.find(params[:id])
  end
  
end
