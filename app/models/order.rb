class Order < ActiveRecord::Base
  has_many :order_item
  before_create :set_price
  
  def import(file)
    filepath = "#{Rails.root}/example_input.tab"
  	fullprice = 0.0

			CSV.foreach(filepath, { :headers => true, :col_sep => "\t", :skip_blanks => true }) do |item|
		    	purchaser_name	= item[0]
					item_description = item[1]
					item_price = BigDecimal.new(item[2])
					purchase_count = item[3].to_i
					merchant_address = item[4]
					merchant_name = item[5]

      		purchaser = Purchaser.find_or_create_by(name: purchaser_name)
      		item = Item.find_or_create_by(description: item_description, price: item_price)
      		merchant = Merchant.find_or_create_by(name: merchant_name, address: merchant_address)
  				price = item_price * purchase_count

  				order_item = OrderItem.create(order: self, purchaser: purchaser, item: item, merchant: merchant, price:price, quantity:purchase_count)

  				fullprice += price
    	end
    self.update(filename: filepath, price: fullprice)
  end


  private
  def set_price
    self.price = 0.0
  end

end
