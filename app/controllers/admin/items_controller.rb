class Admin::ItemsController < ApplicationController
  
  before_action :authenticate_admin!  #商品を閲覧・作成・編集する機能はログイン済の管理者のみ権限を付与する
  before_action :set_product, only: %i[show edit update]
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新規商品の登録に成功しました。"
      redirect_to admin_items_path(@item.id)
    else
      flash[:notice] = "新規商品の登録に失敗しました。"
      @items = Item.new
      render :new
    end
  end
  
  def index
    @items = Item.all
    # @items = Kaminari.paginate_array(@items).page(params[:page]).per(5)
    #ページネーション実装してない
  end

  def show
  end

  def edit
  end
  
  def update
    if @item.update(item_params)
      flash[:notice] = "商品の変更に成功しました。"
      redirect_to admin_items_path(@item.id)
    else
      flash[:notice] = "商品の変更に失敗しました。"
      render :edit
    end
  end
  
  
  private
  
  
  def set_product
    @item = Item.find(params[:id])
  end
  
  def item_params
    params.require(:item).permit %i(name introduction price image genre_id is_active)
  end
  
end
