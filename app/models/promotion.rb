class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  has_many :product_category_promotions, dependent: :destroy
  has_many :product_categories, through: :product_category_promotions, dependent: :destroy
  # pural de product_categories, pq sao varias; e passa a tabela (plural) pra unir - join table)

  validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date,
            presence: true
  validates :code, uniqueness: true
  validates :coupon_quantity, numericality: { greater_than: 0, message: 'Deve ser maior que 0' }

  scope :search, lambda { |query|
                   where('name like ? OR description like ? OR code like ?',
                         "%#{query}%", "%#{query}%", "%#{query}%")
                 }

  def generate_coupons!
    raise 'Cupons já foram gerados' if coupons.any?

    codes =
      (1..coupon_quantity).map do |number|
        { code: "#{code}-#{'%04d' % number}" }
      end
    coupons
      .create_with(created_at: Time.zone.now, updated_at: Time.zone.now)
      .insert_all!(codes)
  end
end
