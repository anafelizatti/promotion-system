class Coupon < ApplicationRecord
    belongs_to :promotion
    scope :search, ->(query) {where('code like ?', "%#{query}%")}
    
    enum status: {active: 0, inactivate: 10, burn: 20}

    validates :order, presence: true, on: :coupon_burn

    def title
      "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
    end

    def as_json(options = {}) #sobrescrever o método as_jason do cupom
      super({methods: %i[discount_rate expiration_date],
            only: %i[]}.merge(options))
    end

    def burn!(order)
      self.order = order
      self.status = :burn
      save!(context: :coupon_burn)

      #raise ActiveRecord::RecordInvalid unless order.present?
      #update!(order: order, status: :burn)
      #save! levanta o mesmo erro do RecordInvalid, então o rescue continua funcionando no controller.
    end
  

    private

    def discount_rate
      promotion.discount_rate
    end

    def expiration_date
      I18n.l(promotion.expiration_date)
    end

end
