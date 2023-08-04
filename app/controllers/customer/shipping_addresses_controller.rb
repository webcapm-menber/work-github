class Customer::ShippingAddressesController < ApplicationController
  
  before_action :authenticate_customer!
  before_action :set_product, only: %i[create edit update destroy]

  def index
    @shipping_addresses = ShippingAddress.all
    @shipping_address = ShippingAddress.new(shipping_address_params)
  end

  def create
    if @shipping_address.save
      flash[:notice] = "配送先情報の登録に成功しました。"
      redirect_to shipping_addresses_path
    else
      flash[:notice] = "配送先情報の登録に失敗しました。"
      render :index
    end
  end

  def edit
  end

  def update
    if @shipping_address.update(shipping_address_params)
      flash[:notice] = "配送先情報の更新に成功しました。"
      redirect_to shipping_addresses_path
    else
      flash[:notice] = "配送先情報の更新に失敗しました。"
      render :edit
    end

  end

  def destroy
    @shipping_address.destroy
    flash[:notice] = "配送先情報の削除に成功しました。"
    redirect_to shipping_addresses_path
  end


  private

  def set_product
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:address, :postal_code, :address_name)
  end

end
