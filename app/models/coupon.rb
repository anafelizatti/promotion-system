class Coupon < ApplicationRecord
  belongs_to :promotion, dependent: :destroy
  scope :search, ->(query) { where('code equal ?', "%#{query}%") }
  enum status: { active: 0, inactivate: 10, burn: 20 }
  validates :order, presence: true, on: :coupon_burn

  def title
    "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
  end

  def as_json(options = {})
    super({ methods: %i[discount_rate expiration_date],
            only: %i[] }.merge(options))
  end

  def burn!(order)
    self.order = order
    self.status = :burn
    save!(context: :coupon_burn)
    # raise ActiveRecord::RecordInvalid unless order.present?
    # update!(order: order, status: :burn)
    # save! levanta o mesmo erro do RecordInvalid, entao o rescue continua funcionando no controller.
  end

  delegate :discount_rate, to: :promotion

  def expiration_date
    I18n.l(promotion.expiration_date)
  end

  def expired?
    promotion.expiration_date < Date.current
  end

  def category_is_valid?(category)
    if promotion.product_categories.count.zero? || (category.nill? && promotion.product_categories.find_by(code: category))
      return true
    end

    false
  end
end
