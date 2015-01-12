class ProductsRenameProductNameToName < ActiveRecord::Migration
  def up
    rename_column :products, :product_name, :name
  end

  def down
    rename_column :products, :name, :product_name
  end
end
