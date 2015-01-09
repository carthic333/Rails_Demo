include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :category do
		name "category1" 
		thumburl "https://www.google.com/123.jpg"
    image { fixture_file_upload(Rails.root.join('spec/fixtures/files/missing.jpg'), 'image/jpg') }

    trait :category_no_name do
      name "" 
      thumburl "https://www.google.com/123.jpg"
    end

    trait :category_no_url do
      name "Name" 
      thumburl ""
    end

    # after_create do |image, proxy|
      # proxy.file.close
    # end 
  end

end
