class OrdersController < ApplicationController

	before_action :authenticate_user!
	before_action :find_order, only: [:show, :destroy]

	respond_to :html
	respond_to :json, only: [:index, :show]

	# Finds all Orders to show
	def index
		@orders = Order.all
		respond_with @orders
	end

	# Finds OrderItems for desidred Order
	def show
		respond_with @order
	end

	# Destroy desired Order
	def destroy
		@order.destroy
		redirect_to root_path
	end

	# Create Order object and calls import
	# If imported file is nil shows an error message
	# If occur any error, a message is shown
	def import
    	begin
    		if (file = params[:file]).nil?
    			flash[:error] = "Error: You must select a file."
    		else
    			@order = current_user.order.build
    			@order.import(file)
    			flash[:success] = "File successuly imported!"
	    	end
	    	redirect_to root_path
    	rescue
   			flash[:error] = "Error: The selected file cannot be imported."
    		@order.destroy
    		redirect_to root_path
   		end
	end


	private
		# Find Order by ID
		# If its null, redirect to root path
		def find_order
			begin
				@order = Order.find(params[:id])
			rescue
				flash[:error] = "Error: The Order with id #{params[:id]} does not exists."
				redirect_to root_path
			end
		end

		# Strong params
		def post_params
			params.require(:order).permit(:price, :filename, :user_id)
		end
end
