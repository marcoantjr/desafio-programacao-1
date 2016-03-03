class OrdersController < ApplicationController

	before_action :authenticate_user!

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
	    	redirect_to root_path
    	rescue
    		if(@file.nil?)
    			flash[:error] = "Error: You must select a file."
    		else
    			flash[:error] = "Error: The #{@file.original_filename} cannot be imported."
    		end
    		@order.destroy
    		redirect_to root_path
   		end
	end


	private
		def find_order
			begin
				@order = Order.find(params[:id])
			rescue
				redirect_to root_path
			end
		end

		def post_params
			params.require(:order).permit(:price, :filename, :user_id)
		end
end
