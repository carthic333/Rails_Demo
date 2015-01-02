require 'rails_helper'
before_action :authenticate_user!

RSpec.describe ProductsController, :type => :controller do
	it "assigns @products" do
		products = Product.all
		get :index
		expect(assigns(:products)).to eq(products)
	end

	it "renders the template for index page" do
		get :index
		expect(response).to render_template("index")
	end

	it "should have status 200" do
		get :index
		expect(response.status).to eq(200)
	end

	it "assigns new product" do
		product = Product.new
		get :new
		expect(assigns(:product).id).to eq(product.id)
	end
end
