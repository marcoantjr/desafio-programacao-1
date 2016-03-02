class OrderItem < ActiveRecord::Base
  belongs_to :order
  has_one :purchaser
  has_one :product
  has_one :merchant
end
