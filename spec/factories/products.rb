FactoryGirl.define do
  factory :product do
    product_name "Product Name"
		price 10.00
		thumburl "http://www.google.com/123.jpg"
		tax_rate 12
		association :category
		
		trait :product_no_name do
			product_name ""
		end
		
		trait :product_neg_price do
			price -12.00
		end
  
		trait :product_neg_tax do
			tax_rate -12
		end
		
		trait :product_empty_url do
			thumburl ""
		end
		
		trait :product_bad_url do
			thumburl "google.com/123.jpg"
		end
  end
end
