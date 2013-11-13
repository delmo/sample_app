class User < ActiveRecord::Base
 #Rails API entry on callbacks is used to force downcase
 #before saving the email.
 
 before_save { self.email = email.downcase }
 
 #Regex for email validation
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false })

 #validation for name presence and length of <= 50
 validates(:name, presence: true, length: { maximum: 50 } )

 validates(:password, length: {minimum: 6})

 #Check for secure password
 #when password is not present
 #and when password doesn't match confirmation
 has_secure_password

end
