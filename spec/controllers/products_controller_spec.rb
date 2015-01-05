require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  Products.before :each do
    @user = FactoryGirl.create :user
    sign_in @user
  end
	it "assigns @products" do
    #sign_in :product, @user
		products = Product.all
		get :index
    binding.pry
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
