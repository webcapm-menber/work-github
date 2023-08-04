class Customer < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  with_options presence: true do 
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
    validates :email
    validates :encrypted_password
    validates :postal_code
    validates :address
    validates :telephone_number
  end
  
  validates :postal_code, length: { minimum: 7}
  # nameの文字数制限
  
  has_many :shipping_addresses, dependent: :destroy
  
end
