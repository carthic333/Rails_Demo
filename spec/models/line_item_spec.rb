require 'rails_helper'

RSpec.describe LineItem, :type => :model do
	let(:line_item) { FactoryGirl.create(:line_item) }

	it "do not have negative total, quantity, unit price, tax" do
		expect(line_item.unit_price).to be >= 0
		expect(line_item.quantity).to be >= 0
		expect(line_item.tax).to be >= 0
		expect(line_item.total).to be >= 0
	end

end
