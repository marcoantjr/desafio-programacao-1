require 'test_helper'

include ActionDispatch::TestProcess

class OrderTest < ActiveSupport::TestCase
	fixtures(:orders)

	test "should import file" do
		file = fixture_file_upload("files/input.tab", "text/plain")
		order = Order.first
		order.import(file)

		order_items = OrderItem.where(order_id: order.id)
		assert_not_nil order_items

		order_items_prices = order_items.map {|item| item["price"]}.reduce(0, :+)
		assert_equal order.price, order_items_prices

		assert_equal order.filename, file.original_filename
	end


end
