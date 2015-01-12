require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  let(:category) { FactoryGirl.create(:category) }
  
  it "assigns @categories" do
    categories = Category.all
    get :index
    expect(assigns(:categories)).to eq(categories)
  end

  it "renders the template for index page" do
    get :index
    expect(response).to render_template("index")
  end

  it "should have status 200" do
    get :index
    expect(response.status).to eq(200)
  end

  it "assigns new category" do
    category_new = Category.new
    get :new
    expect(assigns(:category).id).to eq(category_new.id)
  end

  it "assigns category with matched id for edit" do
    get :edit, :id => category.id
    expect(assigns(:category).id).to eq(category.id)
    expect(response.status).to eq(200)
  end

  it "assigns category with matched id for delete" do
    get :delete, :id => category.id
    expect(assigns(:category).id).to eq(category.id)
    expect(response.status).to eq(200)
  end

  it "create should have response status 302" do
    post :create, :category => { name: "category1", thumburl: "https://www.google.com/123.jpg" }
    expect(response.status).to eq(302)
    expect(response).to redirect_to(controller: :categories, action: :index)
  end

  it "should have attached file / allows image to be added to category" do 
    expect(category).to have_attached_file(:image) 
  end

  it "should not have attached file / allows image to be removed from category" do 
    # category.image = nil
    # expect(category.image.exists?).to eq(false)
    
    # ^ OR V
    category.image = nil
    get :edit, :id => category.id
    expect(assigns(:category).id).to eq(category.id)
    expect(category.image.exists?).to eq(false)
  end
end
