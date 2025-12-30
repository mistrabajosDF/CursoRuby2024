class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  
  has_one_attached :image

  attr_accessor :image_attached

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :stock, presence: true
  validates :price, presence: true
  validates :color, length: { maximum: 100 }
  validates :category_id, presence: true
end
