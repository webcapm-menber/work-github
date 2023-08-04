class Public::CustomersController < ApplicationController
  
  before_action :authenticate_customer!
  before_action :set_product, only: %i[show edit update unsubscribe withdrawal]

  def show
  end

  def edit
  end
  
  def update
    if @customer.update(customer_params)
      redirect_to public_customers_show_path, notice: "会員情報の編集に成功しました。"
    else
      flash[:notice] = "会員情報の編集に失敗しました。"
      render  :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdrawal
    Customer.update(is_deleted: true)  #is_deletedカラムをtrueに変更する
    reset_session #セッション情報を全て削除
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to public_root_path
  end
  
  
  private
  
  def set_product
    @customer = current_customer
  end
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  end
  
  
end
