class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category added Successfully"
      redirect_to(:action => 'index')
    else
      str = ''
      @category.errors.messages.each { |key, value| str += "#{key} #{value[0]}," }
      flash[:alert] = str
      render('new')
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if params[:delete] and params[:delete][:checked].to_i == 1
      @category.image = nil
    end

    if @category.update_attributes(category_params)
      flash[:notice] = "Category updated Successfully"
      redirect_to(:action => 'show', :id => @category.id)
    else
      str = ''
      @category.errors.messages.each { |key, value| str += "#{key} #{value[0]}," }
      flash[:alert] = str
      render('edit')
    end
  end

  def delete
    @category = Category.find(params[:id])
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:notice] = "Category deleted Successfully"
    redirect_to(:action => 'index') 
  end

  private

  def category_params
    params.require(:category).permit(:name, :image)
  end
end
