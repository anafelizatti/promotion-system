FactoryBot.define do
    factory :promotion do
      name { 'Dia do consumidor' }
      description  { 'Promoção dia dos consumidores' }
      code { 'CONS10' }
      discount_rate { 10 }
      coupon_quantity { 100 }
      expiration_date { '22/12/2033'}
    end
  end