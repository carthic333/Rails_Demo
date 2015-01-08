require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, user: user) }
  before do
    sign_in user
  end
  
  it "assigns @orders" do
    orders = Order.where(user_id: user.id)
    get :index
    expect(assigns(:orders)).to eq(orders)
  end

  it "renders the template for index page" do
    get :index
    expect(response).to render_template("index")
  end

  it "should have status 200" do
    get :index
    expect(response.status).to eq(200)
  end

  it "changes the order status to checkout" do
    post :checkout, :id => order.id
    expect(response.status).to eq(302)
    expect(response).to redirect_to(controller: :orders, action: :show, id: order.id)
  end

  it "authorize the order and redirect ot orders index" do
    post :authorize, :id => order.id, :order => { billing_address: '#some_Address', shipping_address: '#some_address' }, :Credit_card => { number:'123456', exp_date: '1/2/2015', cvv_no: '123'}
    
    expect(response.status).to eq(302)
    expect(response).to redirect_to(controller: :orders, action: :index)
  end

  it "cancel's the order and reidrect to orders index" do
    post :cancel, :id => order.id
    expect(response.status).to eq(302)
    expect(response).to redirect_to(controller: :orders, action: :index)
  end
end
