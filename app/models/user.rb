class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
	has_secure_password
	has_many :schedules, dependent: :destroy
	before_save :create_remember_token

	validates :name, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
