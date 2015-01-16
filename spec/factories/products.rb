FactoryGirl.define do
  factory :product do
    name "Product Name"
    description "some description"
		price 10.00
		tax_rate 12
		association :category
		
		trait :product_no_name do
			name ""
		end
		
		trait :product_neg_price do
			price -12.00
		end
  
		trait :product_neg_tax do
			tax_rate -12
		end
  end
end
