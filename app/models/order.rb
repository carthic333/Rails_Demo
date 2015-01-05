class Order < ActiveRecord::Base
  has_many :line_items
  belongs_to :user

  validates :status, :user_id, presence: true
  validates_presence_of :billing_address, :shipping_address, if: Proc.new { |order| order.status == 'payment_complete' }
  validates :status, inclusion: {in: ['cart', 'checkout', 'payment_complete', 'cancelled']}
  after_initialize :initilize_order

  def initilize_order
    self.status ||= 'cart'
    self.subtotal ||= 0
    self.total ||= 0
  end

  def recalculate
    # Recalculate Order total
    self.subtotal = 0
    self.tax = 0
    self.total = 0
    line_items.each { |l| self.subtotal += l.total; self.tax += l.tax }
    self.total = subtotal + tax
    self.save!
  end

  def authorize (credit_card)
    unless credit_card[:number] == ""
      self.status = 'payment_complete'
      self.save
      str = "Card Details\n Number: " + credit_card[:number] 
      str += "\nExpairy Date: " + credit_card[:exp_date] 
      str += "\nCard CVV Number: " + credit_card[:cvv_no]
    else
      "Fields are Empty"
    end
  end
end
