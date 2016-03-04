class Order < ActiveRecord::Base

	belongs_to :user
  has_many :order_item, dependent: :destroy

  before_create :set_price

  require 'csv'
  

  # Imports method work following steps below:
  # 1) Receives a file from controller;
  # 2) Reads it line by line (First line is considered header; The file is tab separeted; And ignore white lines)
  # 2.1) For each line, columns become variables to create objects;
  # 2.2) Creates all the objects for OrderItem relationship;
  # 2.3) Calculates the OrderItem price by multiplying the quantity with item price;
  # 2.4) Creates the OrderItem with correct relations;
  # 2.5) Sums price with full price;
  # 3) Updates Order object;
  
  def import(file)
    fullprice = 0.0
    if file.nil?
      raise "File is nil!"
    else
  			CSV.foreach(file.path, { :headers => true, :col_sep => "\t", :skip_blanks => true }) do |item|

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

    				order_item = OrderItem.create(order: self, purchaser: purchaser, item: item, merchant: merchant, price: price, quantity: purchase_count)

    				fullprice += price
      	end
      self.update(filename: file.original_filename, price: fullprice)
    end
  end

  private
  def set_price
    self.price = 0.0
  end

end
