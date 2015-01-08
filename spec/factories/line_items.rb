FactoryGirl.define do
  factory :line_item do
		quantity 2
		association :order
		association :product

		trait :line_item2 do
			unit_price -123
			tax -21
			total 0
			quantity -1
		end
  end

end
