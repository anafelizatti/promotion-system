class ProductCategory < ApplicationRecord
    validates :name, :code,  
    presence: { message: 'não pode ficar em branco'}
    validates :code, uniqueness: { message: 'deve ser único'}
    scope :search, ->(query) {where('name like ? OR code like ?',
  "%#{query}%", "%#{query}%")}
end
