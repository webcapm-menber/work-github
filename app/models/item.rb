class Item < ApplicationRecord
  
  with_options presence: true do
  
    validates :name
    validates :introduction
    validates :price
    validates :image
    validates :is_active
  
  end
  
  has_one_attached :image
  
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  
  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
  
end
