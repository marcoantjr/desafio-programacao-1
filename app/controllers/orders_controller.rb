class OrdersController < ApplicationController
	
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
		@order.destroy
		redirect_to root_path
	end

	private
		def find_post
			@order = Order.find(params[:id])
		end

		def post_params
			params.require(:order).permit(:price, :user_id)
		end
end
