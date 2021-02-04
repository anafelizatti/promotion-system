class ProductCategory < ApplicationRecord
  has_many :product_category_promotions, dependent: :destroy
  has_many :promotions
  validates :name, :code, presence: true
  validates :name, :code, uniqueness: true
  scope :search, ->(query) { where('name like ? OR code like ?', "%#{query}%", "%#{query}%") }
end

