class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 100 }
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :phone, presence: true

  has_one :cart, dependent: :destroy
  has_many :orders

  after_create :create_cart

  has_one :cart, dependent: :destroy
end
