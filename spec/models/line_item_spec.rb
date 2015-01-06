require 'rails_helper'

RSpec.describe LineItem, :type => :model do
  let(:line_item) { FactoryGirl.create(:line_item) }
  it "do not have negative total, quantity, unit price, tax" do
    expect(line_item.unit_price).to be >= 0
    expect(line_item.quantity).to be >= 0
    expect(line_item.tax).to be >= 0
    expect(line_item.total).to be >= 0
  end

  it "should calculate unit_price, tax_rate and total" do
    expect(line_item.unit_price).to eq(line_item.product.price)
    tax = ((line_item.product.price * line_item.product.tax_rate) / 100) * line_item.quantity
    expect(line_item.tax).to eq(tax)
    expect(line_item.total).to eq(line_item.unit_price * line_item.quantity)
  end

  binding.pry
  it "updates quantity and recalculates the line_item, order total" do
    expect { line_item.update_quantity(3) }.to change{line_item.total}.by(line_item.unit_price)

   # expect { order.line_items[0].update_quantity(3) }.to change{order.subtotal}.by(line_item.unit_price)
  end 

  it "destroy and recalculates the order total" do
    binding.pry
    # line_item2 = FactoryGirl.create(:line_item)
    # order = line_item.order
    binding.pry
    expect { 
      line_item.destroy
      binding.pry
    }.to change{Order.where(status: 'cart').subtotal}.by(line_item.total)
  end
end
