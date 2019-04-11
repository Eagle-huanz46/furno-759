class User < ApplicationRecord
	has_many :articles, dependent: :destroy
	#dependent means when the user is deleted, all the related articles with the user id also delete
	has_many :comments, dependent: :destroy
	before_save {self.email = email.downcase}
	validates :username, presence:true, uniqueness: {case_sensitive: false}, length:{minimum: 3, maximum: 25}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX, message: "is in a wrong format" }
	has_secure_password
end
#before_save means save all email in downcase format
#case sensitive prevent Eagle is different to eagle
#REGEX valides the email format, do not need to understand