class ShippingAddress < ApplicationRecord
  
  with_options presence: true do
    validates :address
    validates :postal_code
    validates :address_name
  end
  
  belongs_to :customer
  
end
