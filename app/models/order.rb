class Order < ActiveRecord::Base
  has_many :order_item
  before_create :set_price
  

  private
  def set_price
    self.price = 0.0
  end

end
