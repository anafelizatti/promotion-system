require 'rails_helper'

describe 'ProductCategory' do
  it 'successfully' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
    login_as user, scope: :user

    visit product_categories_path
    fill_in 'search', with: 'hosp'
    click_on 'Pesquisar'

    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('HOSP')
  end

  it 'and receive a message if not found' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
    login_as user, scope: :user

    visit product_categories_path
    fill_in 'search', with: 'LOREM'
    click_on 'Pesquisar'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end
end