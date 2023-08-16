class Customer::CartItemsController < ApplicationController

  before_action :authenticate_customer!
  before_action :set_params, only: %i[update destroy]

  def index
    @cart_items = current_customer.cart_items.all
    @count = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }  #合計金額の計算
  end

  def create
    # cart_item = CartItem.new(cart_item_params)
    # cart_item.customer_id = current_customer.id
    #省略した形↓↓↓
    cart_item = current_customer.cart_items.new(cart_item_params)
    
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path, notice: "カートへの保存に成功しました。"
    else
      if cart_item.save
          redirect_to cart_items_path, notice: "カートへの保存に成功しました。"
      else
          render :index, notice: "カートへの保存に失敗しました。"
          # render template: "customer/items/show", notice: "カートへの保存に失敗しました。"
          # @cart_item = CartItem.new
          # @item = Item.find(params[:id])
          # render template: "customer/items/show"
      end
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "数量の変更に成功しました。"
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private


  def set_params
    @cart_item = CartItem.find(params[:id])
  end

  #ストロングパラメータ
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
