require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
	it "assigns @orders" do
		orders = Order.all
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

	it "assigns new order" do
		order = Order.new
		get :new
		expect(assigns(:order).id).to eq(order.id)
	end
end
