class Purchaser < ActiveRecord::Base
	has_many :order_item
end
