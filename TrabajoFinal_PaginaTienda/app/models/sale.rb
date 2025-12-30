class Sale < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :customer, optional: true

  validates :total, presence: true

  validates :customer, presence: true, unless: -> { user.present? }
  validates :user, presence: true, unless: -> { customer.present? }

  def self.create_from_customer!(customer:, customer_name:, customer_id:, total:, products:, state:)
    self.create!(
      customer: customer,
      customer_name: customer_name,
      customer_id: customer_id,
      total: total,
      products: products,
      state: state
    )
  end
end