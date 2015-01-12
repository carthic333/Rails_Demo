require 'rails_helper'

RSpec.describe Product, :type => :model do
  let(:product) { FactoryGirl.create(:product) }
  let(:user) { FactoryGirl.create(:user) }
  
  it "do not have empty product name" do
    expect(product.name).not_to be_empty  
  end

  it "do not have empty price" do
    expect(product.price).not_to be_zero  
  end

  it "do not have negative price" do
    expect(product.price).to be >= 0  
  end

  it "do not have negative tax rate" do
    expect(product.tax_rate).to be >= 0 
  end

  it "should rais error when name is empty" do
    expect { 
      product.name = nil
      product.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should rais error when price is empty" do
    expect { 
      product.price = nil
      product.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should rais error when price is negative" do
    expect { 
      product.price = -1
      product.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should rais error when price is invalid" do
    expect { 
      product.price = 'abc'
      product.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "should rais error when tax_rate is empty" do
    expect { 
      product.tax_rate = nil
      product.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should rais error when tax_rate is negative" do
    expect { 
      product.tax_rate = -1
      product.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should rais error when tax_rate is invalid" do
    expect { 
      product.tax_rate = 'abc'
      product.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should increase lineitem count by 1 when added" do
    expect { product.add_to_cart(1, user) }.to change(LineItem, :count).by(1)
  end
  
  it "should increase lineitem qty when existing product is added" do
    expect {
      product.add_to_cart(1, user)
      product.add_to_cart(1, user)
    }.to change(LineItem, :count).by(2)
  end
end
