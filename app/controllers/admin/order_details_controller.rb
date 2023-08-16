class Admin::OrderDetailsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def update
    order_detail = OrderDetail.find(params[:id])
    order = order_detail.order
    order_details = order.order_details.all
    if order_detail.update(production_status: params[:order_detail][:production_status])
      redirect_to admin_order_path(order.id)
      flash[:notice] = "注文商品の更新に成功しました。"
    else
      flash[:notice] = "注文商品の更新に失敗しました。"
      render  template: "orders/show"
    end
    
    order.update(status: 2) if order_detail.production_status == "production"
    is_updated = true
    # 紐付いている注文商品の製作ステータスが "すべて" [製作完了]になった際に注文ステータスを「発送準備中」に更新させる
    order_details.each do |order_detail|
      unless order_detail.production_status == "completion_production"  # 製作ステータスが「製作完了」ではない場合 
          is_updated = false  # 上記で定義してあるis_updatedを「false」に変更する。
      end
    end
    order.update(status: 3) if is_updated
    # is_updatedがtrueの場合に、注文ステータスが「発送準備中」に更新されます。上記のif文でis_updatedがfalseになっている場合、更新されません。
  end
  
end
