class Product < ActiveRecord::Base
	belongs_to :category
	has_many :line_items

	validates :product_name, :category_id, :thumburl, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0 }
	validates :tax_rate, numericality: { greater_than_or_equal_to: 0 }
	validates :thumburl, format: { with: URI::regexp(%w(http https)) }

	def add_to_cart (qty, current_user)
		#order = Order.select { |o| o.user_id == current_user.id && o.status == 'cart' }
		order = Order.find_by(user_id: current_user.id, status: 'cart')
		order ||= Order.create(user_id: current_user.id)
		if order
			lineitem = LineItem.create(order_id: order.id, product_id: id, quantity: qty)
			return order
		end
		false
	end
end
