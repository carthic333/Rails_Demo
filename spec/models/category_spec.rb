require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:category) { FactoryGirl.create(:category) }
  let(:category_no_name) { FactoryGirl.create(:category, :category_no_name) }
  let(:category_no_url) { FactoryGirl.create(:category, :category_no_url) }

  it "should not have empty name" do
    expect( category.name ).not_to be_empty
  end
  
  it "should not have empty thumburl" do
    expect( category.thumburl ).not_to be_empty
  end
  
  it "shouldnot have bad thumburl" do
    expect( category.thumburl ).to match(/^http(s?)\W/)
  end

  it "should raise error when saving a category without a name" do
    expect{ category_no_name.save }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should raise error when saving a category without a name" do
    expect{ category_no_url.save }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
