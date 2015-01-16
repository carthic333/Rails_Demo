require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product) }
  before do
    sign_in user
  end
  
  it "assigns @products" do
    products = Product.all
    get :index
    expect(assigns(:products)).to eq(products)
  end

  it "renders the template for index page and status 200" do
    get :index
    expect(response).to render_template("index")
    expect(response.status).to eq(200)
  end

  it "assigns new product" do
    product_new = Product.new
    get :new
    expect(assigns(:product).id).to eq(product_new.id)
  end

  it "assigns product with matched id for edit" do
    get :edit, :id => product.id
    expect(assigns(:product).id).to eq(product.id)
    expect(response.status).to eq(200)
  end

  it "assigns product with matched id for delete" do
    get :delete, :id => product.id
    expect(assigns(:product).id).to eq(product.id)
    expect(response.status).to eq(200)
  end

  it "adds the line_item to cart and redirects to order show" do
    post :add_to_cart, :id => product.id, :qty => { :values => "2" }
    expect(response.status).to eq(302)
    expect(response).to redirect_to(controller: :orders, action: :show, id: Order.where(status: "cart").first.id)
  end

  it "should have attached file / allows image to be added to product" do 
    expect(product).to have_attached_file(:image) 
  end

  it "should not have attached file / allows image to be removed from product" do 
    # product.image = nil
    # expect(product.image.exists?).to eq(false)
    
    # ^ OR V
    product.image = nil
    get :edit, :id => product.id
    expect(assigns(:product).id).to eq(product.id)
    expect(product.image.exists?).to eq(false)
  end
end
