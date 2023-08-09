class OrderDetail < ApplicationRecord
  
  with_options presence: true do
    validates :production_status
    validates :quantity
    validates :price
  end
  
  belongs_to :Item
  belongs_to :Order
  
end
