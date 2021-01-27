class ProductCategory < ApplicationRecord
    has_many :product_category_promotions
    validates :name, :code, presence: true
    validates :code, uniqueness: { message: 'deve ser único'}
    scope :search, ->(query) {where('name like ? OR code like ?', "%#{query}%", "%#{query}%")}
    enum status: {valid: 0, invalid: 10, burn: 20}
end


