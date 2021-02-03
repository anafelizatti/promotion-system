require 'rails_helper'

describe 'Promotion' do
  xit 'Promotion registrator cannot authorizes its own promotion' do
    expect(page).to have_content(teste)
  end

  xit 'Not promotion-creator can authorizes promotions' do
    expect(page).not_to have_content(teste)
  end
end