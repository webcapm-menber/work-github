class ShippingAddress < ApplicationRecord
  
  with_options presence: true do
    validates :address
    validates :postal_code
    validates :address_name
  end
  
  # with_options uniqueness: true do
  #   validates :address
  #   validates :postal_code
  # end
  
  belongs_to :customer
  
  def address_display
  '〒' + postal_code + ' ' + address + ' ' + address_name
  end
  
end
