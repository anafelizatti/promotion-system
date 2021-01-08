class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

validate :email_domain

  def email_domain
    domain = email.split("@").last
    if !email.blank?
      errors.add(:email, ": domínio inválido") unless domain.include?('locaweb.com.br')
    end
  end
  
end
