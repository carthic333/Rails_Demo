FactoryGirl.define do
  factory :order do
		shipping_address "#some address Here"
		billing_address "#some address Here"
		status "cart"
		subtotal 123
		tax 21
		total 144
		association :user

		trait :order_empty do
			shipping_address ""
			billing_address ""
			status ""
			subtotal 
			tax 
			total 
		end

		trait :order do
			subtotal 123
			tax 21
			total 145
		end
  end

end
