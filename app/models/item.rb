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
  
end
