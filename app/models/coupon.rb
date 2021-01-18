class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: {active: 0, inactivate: 10, burn: 20}

  def title
    "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
  end

end
