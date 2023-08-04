# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  before_action :customer_state, only: [:create]
  
  def after_sign_out_path_for(resource)
    public_root_path
  end   
  
  def after_sign_in_path_for(resource)
    public_root_path
  end
  
  protected

  def customer_state                                                # 退会しているかを判断するメソッド
    @customer = Customer.find_by(email: params[:customer][:email])  # 【処理内容1】 入力されたemailからアカウントを1件取得
    return if !@customer                                            # アカウントを取得できなかった場合、このメソッドを終了する
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == true 
      #【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別 & 退会フラグの値がTrueの場合は下の処理を実行する(Falseの場合は何もしない)
      flash[:notice] = '退会済みです。'
      redirect_to new_customer_registration_path
    else
      flash[:notice] = 'ログイン情報が間違っています。再度ご入力してください。'
    end
  end
  
end