class User < ActiveRecord::Base
 #Rails API entry on callbacks is used to force downcase
 #before saving the email.
 
 # before_save { self.email = email.downcase }
 before_save { email.downcase! }

 #Regex for email validation
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
 validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false })

 #validation for name presence and length of <= 50
 validates(:name, presence: true, length: { maximum: 50 } )

 validates(:password, length: {minimum: 6})

 #Check for secure password
 #when password is not present
 #and when password doesn't match confirmation
 has_secure_password

 # Use self.remember_token to save in database and
 # not create local variable
 # use token.to_s to avoid nil produce by a browser
 before_create :create_remember_token

 def User.new_remember_token
  SecureRandom.urlsafe_base64
 end

 def User.encrypt(token)
  Digest::SHA1.hexdigest(token.to_s)
 end

 private
  def create_remember_token
   self.remember_token = User.encrypt(User.new_remember_token)
  end
end
