require 'rails_helper'

RSpec.describe LineItemsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, user: user) }
  let(:line_item) { FactoryGirl.create(:line_item, order: order) }
  before do
    sign_in user
  end
  
  it "assigns line_item with matched id for delete" do
    get :delete, :id => line_item.id
    expect(response.status).to eq(302)
    expect(response).to redirect_to("/orders/" + order.id.to_s) 
  end

  it "updates line_item and redirects to order index" do
    post :update_quantity, :id => line_item.id, :line_item => { qty: 3 }
    expect(response.status).to eq(302)
    expect(response).to redirect_to("/orders/" + order.id.to_s) 
  end
end
