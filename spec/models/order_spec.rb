require 'rails_helper'

RSpec.describe Order, :type => :model do
	let(:order) { FactoryGirl.create(:order) }
	it "do not have empty shiping address" do
		expect(order.shipping_address).not_to be_empty
	end

	it "do not have empty billing address" do
		expect(order.billing_address).not_to be_empty
	end

	it "do not have empty status" do
		expect(order.status).not_to be_empty
	end

	it "do not have bad  status" do
		expect(order.status).to match(/(cart|cancelled|checkout|payment_complete)/)
	end

	it "do not have empty total, subtotal tax" do
		expect(order.total).not_to be_zero
		expect(order.subtotal).not_to be_zero
		expect(order.tax).not_to be_zero
	end

	it "do not have negative total, subtotal tax" do
		expect(order.total).to be >= 0
		expect(order.subtotal).to be >= 0
		expect(order.tax).to be >= 0
	end
end
