class Merchant < ActiveRecord::Base
		has_many :order_item
end
