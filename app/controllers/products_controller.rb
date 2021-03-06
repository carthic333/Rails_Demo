class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product added Successfully"
      redirect_to(:action => 'index')
    else
      str = ''
      @product.errors.messages.each { |key, value| str += "#{key} #{value[0]}," }
      flash[:notice] = str
      render('new')
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:notice] = "Product updated Successfully"
      redirect_to(:action => 'show', :id => @product.id)
    else
      str = ''
      @product.errors.messages.each { |key, value| str += "#{key} #{value[0]}," }
      flash[:notice] = str
      render('edit')
    end
  end

  def delete
    @product = Product.find(params[:id])
  end
  
  def destroy
    Product.find(params[:id]).destroy
    flash[:notice] = "Product deleted Successfully"
    redirect_to(:action => 'index')
  end
  
  def add_to_cart
    if order = Product.find(params[:id]).add_to_cart(params[:qty].values[0].to_i, current_user) 
    
      redirect_to order_path(order)
    else
      redirect_to products
    end
  end

  private
  def product_params
    params.require(:product).permit(:product_name, :description, :price, :thumburl, :tax_rate, :category_id)
  end
end
