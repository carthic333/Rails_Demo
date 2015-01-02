require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
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
		category = Category.new
		get :new
		expect(assigns(:category).id).to eq(category.id)
	end

	it "assigns category with matched id for edit" do
		get :edit, :id => 2
		expect(assigns(:category).id).to eq(2)
		expect(response.status).to eq(200)
	end

	it "assigns category with matched id for delete" do
		get :delete, :id => 2
		expect(assigns(:category).id).to eq(2)
		expect(response.status).to eq(200)
	end

	it "should have response status 200" do
		post :create, :category => { name: "category1", thumburl: "https://www.google.com/123.jpg" }
		expect(response.status).to eq(302)
		# expect(response).to render_template(:index)
	end
end
