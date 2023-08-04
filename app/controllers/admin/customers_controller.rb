class Admin::CustomersController < ApplicationController
  
  before_action :authenticate_admin!
  before_action :set_product, only: %i[show edit update]
  
  def index
    @customers = Customer.all
  end

  def show
  end

  def edit
  end
  
  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
      flash[:notice] = "会員情報の編集に成功しました。"
    else
      render :edit
      flash[:notice] = "会員情報の編集に失敗しました。"
    end
  end
  
  
  private
  
  def set_product
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
