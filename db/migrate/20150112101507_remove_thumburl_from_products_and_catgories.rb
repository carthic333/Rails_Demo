class RemoveThumburlFromProductsAndCatgories < ActiveRecord::Migration
  def up
		remove_column :categories, :thumburl
		remove_column :products, :thumburl
  end

  def down
		add_column:categories, :thumburl, :string
		add_column:products, :thumburl, :string
  end
end
