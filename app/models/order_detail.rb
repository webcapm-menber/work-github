class OrderDetail < ApplicationRecord
  
  with_options presence: true do
    validates :production_status
    validates :quantity
    validates :price
  end
  
  enum production_status: {
    
    cannot_start: 0,          #着手不可
    waiting_production: 1,    #製作待ち
    production: 2,            #製作中
    completion_production: 3, #製作完了
    
  }
  
  belongs_to :item
  belongs_to :order
  
  def price_def
    (price * 1.1).floor
  end
  
  def subtotal
    price_def * quantity
  end
  
end
