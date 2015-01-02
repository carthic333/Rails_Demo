class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
			t.string :shipping_address
			t.string :status
			t.references :lineitem
      t.timestamps
    end
  end
end
