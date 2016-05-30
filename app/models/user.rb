class User < ActiveRecord::Base
  # destroy all users registrations when user itself is destroyed
  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event
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

  def self.authenticate(email, password)
  #checking if the user was authenticated return true or false
    user = User.find_by(email: email)
  # either user or if user nil will never run authenticate
    user && user.authenticate(password)
  end
end
