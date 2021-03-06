require 'rails_helper'

describe 'User' do
  it 'receive welcome message if domain is locaweb' do
    User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')

    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'jane_doe@locaweb.com.br'
    fill_in 'Senha', with: '123456'
    within 'form' do
      click_on 'Login'
    end

    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_content('jane_doe@locaweb.com.br')
    expect(page).not_to have_link('Login')
    expect(page).to have_link('Logout')
  end

  it 'receive error message if @locaweb it not the domain' do
    visit root_path
    click_on 'Login'
    click_on 'Sign up'
    fill_in 'Email', with: 'jane_doe@teste.com.br'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Registrar-se'
    expect(page).to have_content('Não foi possível salvar user')
    expect(page).to have_content('domínio inválido')
  end

  it 'and can log out' do
    User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')

    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'jane_doe@locaweb.com.br'
    fill_in 'Senha', with: '123456'
    within 'form' do
      click_on 'Login'
    end
    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_content('jane_doe@locaweb.com.br')
    expect(page).not_to have_link('Login')
    expect(page).to have_link('Logout')
    click_on('Logout')
    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).to have_content('Saiu com sucesso')
    expect(page).not_to have_content('jane_doe@locaweb.com.br')
    expect(page).to have_link('Login')
  end
end
