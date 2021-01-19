class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy

  validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date,  
            presence: true
  validates :code, uniqueness: true
  scope :search, ->(query) {where('name like ? OR description like ? OR code like ?',
  "%#{query}%", "%#{query}%", "%#{query}%")}

  def generate_coupons!
    raise 'Cupons já foram gerados' if coupons.any?
    codes = 
      (1..coupon_quantity).map do |number|
        { code: "#{code}-#{'%04d' % number}"}
      end
    coupons
      .create_with(created_at: Time.now, updated_at: Time.now)
      .insert_all!(codes)
  end

end
