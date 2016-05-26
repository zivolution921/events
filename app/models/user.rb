class User < ActiveRecord::Base
  has_secure_password
  # password digest has validations
  # bcrypt ruby gem to encrypt the password
  # automatically create password method with the encrypted pass
  # u.password("secret") will encrypt and store it in password_digest
  # password_confirmation is virtual attribute not mapped into database
  # assigns plain text confirmation pass into instance variable

  validates :name, presence: true
  validates :email, presence: true,                   
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }
end
