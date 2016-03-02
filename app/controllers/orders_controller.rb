class OrdersController < ApplicationController

	before_filter :authenticate_user!

	before_action :find_order, only: [:show, :destroy]

	def index
		@orders = Order.all
	end

	def show
		@order_items = OrderItem.where(order_id: @order.id)
	end

	def destroy
		@order.destroy
		redirect_to root_path
	end

	def import
    	begin
    		@order = Order.new(user_id: current_user.id)
    		@order.import(params[:file])
    		flash[:success] = "File successuly imported!"
	    	redirect_to root_url
    	rescue
    		flash[:error] = "Error: The #{@file.original_filename} cannot be imported."
    		@order.destroy
    		redirect_to root_url
   		end
	end


	private
		def find_order
			@order = Order.find(params[:id])
		end

		def post_params
			params.require(:order).permit(:price, :filename, :user_id)
		end

		def init
			self.price = 0.0
		end
end
