class Superuser < ApplicationRecord
  has_many :institutions
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  #REGEX: Regular Expresion for e-mail format validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #Institution's email validation
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  #Implementing secure password
  has_secure_password
  #Institution's password validation
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
end
