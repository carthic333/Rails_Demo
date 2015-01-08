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
    expect(order.total).not_to be_nil
    expect(order.subtotal).not_to be_nil
    expect(order.tax).not_to be_nil
  end

  it "do not have negative total, subtotal tax" do
    expect(order.total).to be >= 0
    expect(order.subtotal).to be >= 0
    expect(order.tax).to be >= 0
  end

  it "should have zero total when there are no items" do
    if order.line_items.count == 0
       expect( order.total ).to eq(0.0)
    end
  end

  it "should calculate total,tax and subtotal when there is one item" do
    line_item = FactoryGirl.create(:line_item, order: order)
    if order.line_items.count == 1
      expect( order.total ).to eq(line_item.total + line_item.tax)
      expect( order.tax ).to eq(line_item.tax)
      expect( order.subtotal ).to eq(line_item.total)
    end
  end

  it "should calculate total,tax and subtotal when there is more then one item" do
    line_item = FactoryGirl.create(:line_item, order: order)
    line_item2 = FactoryGirl.create(:line_item, order: order)
    line_item2.quantity = 3
    order.line_items.push(line_item2)
    line_item2.save!
    order.save!
    total = 0.0
    if order.line_items.count >= 1
      order.line_items.each{ |o| total += o.total } 
      expect( order.subtotal ).to eq(total)

      total = 0.0
      order.line_items.each{ |o| total += o.tax } 
      expect( order.tax ).to eq(total)

      expect( order.total ).to eq(order.subtotal + order.tax)
    end
  end

  it "should cancel the order" do
    # expect(order.status == 'cancelled').to change{order.status}.to eq('cancelled')
  end
end
