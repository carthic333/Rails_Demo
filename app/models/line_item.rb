class LineItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product

	validates :order_id, :product_id, :quantity, presence: true

	before_save :calculate_total_tax
	after_save :order_recalculate
	after_destroy :order_recalculate

	def order_recalculate
		order.recalculate
	end

	def calculate_total_tax
		self.unit_price = product.price
		self.total = product.price * quantity
		self.tax = ((product.tax_rate *  product.price) / 100) * quantity
	end

	def update_quantity (qty)
		self.quantity = qty
		self.save!
		order
	end

	def remove
		self.destroy
		order
	end
end
