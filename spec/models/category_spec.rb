require 'rails_helper'

RSpec.describe Category, :type => :model do
	let(:category) { FactoryGirl.create(:category)}

	it "should not have empty name" do
		expect(category.name).not_to be_empty
	end
	
	it "should not have empty thumburl" do
		expect(category.thumburl).not_to be_empty
	end
	
	it "shouldnot have bad thumburl" do
		expect(category.thumburl).to match(/^http(s?)\W/)
	end
end
