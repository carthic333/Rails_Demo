include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :category do
		name "category1" 
    description "some description"
    image { fixture_file_upload(Rails.root.join('spec/fixtures/files/missing.jpg'), 'image/jpg') }

    trait :category_no_name do
      name "" 
    end

    # after_create do |image, proxy|
      # proxy.file.close
    # end 
  end

end
