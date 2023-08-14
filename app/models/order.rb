class Order < ApplicationRecord

  with_options presence: true do
    validates :payment_method
    validates :payment
    validates :postage
    validates :address
    validates :postal_code
    validates :address_name
    validates :status
  end
  
  #購入方法
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  #注文ステータス
  enum status: {
    
    waiting_payment: 0,      #入金待ち
    payment_confirmation: 1, #入金確認
    production: 2,           #製作中
    shipping_preparation: 3, #発送準備中
    sent: 4                  #発送済み
    
  }

  # with_options uniqueness: true do
  # end
  
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  def address_display
  '〒' + postal_code + ' ' + address
  end

end
