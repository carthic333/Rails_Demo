FactoryGirl.define do
  factory :category do
		name "category1" 
		thumburl "https://www.google.com/123.jpg"

    trait :category_no_name do
      name "" 
      thumburl "https://www.google.com/123.jpg"
    end

    trait :category_no_url do
      name "Name" 
      thumburl ""
    end
  end

end
