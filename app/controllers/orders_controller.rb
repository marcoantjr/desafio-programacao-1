class OrdersController < ApplicationController

require 'csv'
	
	def index
		@orders = Order.all
	end

	def new
		@order = Order.new
	end

	def create
		@order = Order.create(post_params)
	end

	def destroy
		@order = Order.find(params[:id])
		@order.destroy
		redirect_to root_path
	end

	def import
    	begin
    		@file = params[:file]
			@order = Order.create
			@fullprice = 0.0

			CSV.foreach(@file.path, { :headers => true, :col_sep => "\t", :skip_blanks => true }) do |item|
		
				if (!item.empty?) 
					@purchaser_name	= item[0]
					@item_description = item[1]
					@item_price = BigDecimal.new(item[2])
					@purchase_count = item[3].to_i
					@merchant_address = item[4]
					@merchant_name = item[5]

      				@purchaser = Purchaser.find_or_create_by(name: @purchaser_name)
      				@item = Item.find_or_create_by(description: @item_description, price: @item_price)
      				@merchant = Merchant.find_or_create_by(name: @merchant_name, address: @merchant_address)

      				@price = @item_price * @purchase_count

      				@order_item = OrderItem.create(order_id:@order.id, purchaser_id:@purchaser.id, item_id:@item.id, merchant_id:@merchant.id, price:@price, quantity:@purchase_count)

      				@fullprice += @price
      				

				end
    	    end
    	    @order.update(price:@fullprice)
	    	redirect_to root_url, notice: "Products imported."
    	rescue
    	  redirect_to root_url, notice: "Invalid CSV file format."
   		end
	end


	private
		def find_order
			@order = Order.find(params[:id])
		end

		def post_params
			params.require(:order).permit(:price, :user_id)
		end

		def init
			self.price = 0.0
		end
end
