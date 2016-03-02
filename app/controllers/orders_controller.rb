class OrdersController < ApplicationController

	before_action :find_order, only: [:show, :destroy]


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
	
	def show
		@order_items = OrderItem.where(order_id: @order.id)
	end

	def destroy
		@order.destroy
		redirect_to root_path
	end

	def import
    	begin
    		@order = Order.create
    		@order.import(params[:file])
    		
    		flash[:success] = "File successuly imported!"
	    	redirect_to root_url
    	rescue
    		flash[:error] = "Error: The #{@file} cannot be imported."
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
