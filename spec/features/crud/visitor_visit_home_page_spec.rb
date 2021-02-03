require 'rails_helper'

describe 'Promotion' do
  it 'successfully' do
    visit root_path

    expect(page).to have_content('Promotion System')
    expect(page).to have_content('Boas vindas ao sistema de gestão de '\
                                 'promoções')
    expect(page).to have_link('Login')
  end
end
