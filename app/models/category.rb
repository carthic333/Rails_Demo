class Category < ActiveRecord::Base
  has_many :products
  
  # paperclip intgration
  has_attached_file :image, :styles => { :medium => "300x300>", :thumbnail => "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  validates :name, presence:true
  validates :thumburl, format: { with: URI::regexp(%w(http https)) }
end
