FactoryGirl.define do
  factory :user do
    email "user@test.com"
		password "akjhdksajbcsakcak"

    trait :user2 do
      email "user2@test.com"
      password "asasksaicnakcsakjcn"
    end
  end

end
