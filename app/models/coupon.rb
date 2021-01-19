class Coupon < ApplicationRecord
    belongs_to :promotion
    scope :search, ->(query) {where('name like ? OR code like ? OR status like ?',
      "%#{query}%", "%#{query}%", "%#{query}%")}
    enum status: {active: 0, inactivate: 10, burn: 20}

    def title
      "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
    end

    def as_json(options = {}) #sobrescrever o método as_jason do cupom
      super({methods: %i[discount_rate expiration_date],
            only: %i[]}.merge(options))
    end

    def burn!(order)
      raise ActiveRecord::RecordInvalid unless order.present?
      update!(order: order, status: :burn)
    end
  

    private

    def discount_rate
      promotion.discount_rate
    end

    def expiration_date
      I18n.l(promotion.expiration_date)
    end

end
