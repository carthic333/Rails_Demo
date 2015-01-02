require 'rails_helper'

RSpec.describe Product, :type => :model do
	let(:product) { FactoryGirl.create(:product) }
  
	it "do not have empty product name" do
		expect(product.product_name).not_to be_empty	
	end

	it "do not have empty price" do
		expect(product.price).not_to be_zero	
	end

	it "do not have negative price" do
		expect(product.price).to be >= 0	
	end

	it "do not have empty thumburl" do
		expect(product.thumburl).not_to be_empty	
	end

	it "do not have negative tax rate" do
		expect(product.tax_rate).to be >= 0	
	end

	it "should have thumburl prefixed with http or https" do
		expect(product.thumburl).to match(/^http(s?)\W/)
	end
end
