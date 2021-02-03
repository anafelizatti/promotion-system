require 'rails_helper'

RSpec.describe ProductCategory do
  context 'when validation' do
    it 'attributes cannot be blank' do
      product_category = ProductCategory.new
      product_category.save
      product_category.valid?

      expect(product_category.errors[:name]).to include('não pode ficar em branco')
      expect(product_category.errors[:code]).to include('não pode ficar em branco')
    end

    it 'attributes must be uniq' do
      ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
      product_category = ProductCategory.new(name: 'Hospedagem', code: 'HOSP')
      product_category.valid?

      expect(product_category.errors[:name]).to include('já está em uso')
      expect(product_category.errors[:code]).to include('já está em uso')
    end
  end
end
