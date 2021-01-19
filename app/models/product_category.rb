class ProductCategory < ApplicationRecord
    validates :name, :code,  
    presence: true
    validates :code, uniqueness: { message: 'deve ser único'}
    scope :search, ->(query) {where('name like ? OR code like ?',
  "%#{query}%", "%#{query}%")}
end


