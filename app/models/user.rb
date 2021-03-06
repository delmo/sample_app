class User < ActiveRecord::Base
 has_many :microposts, dependent: :destroy
 has_many :relationships, foreign_key: "follower_id", dependent: :destroy
 has_many :followed_users, through: :relationships, source: :followed

 has_many :reverse_relationships, foreign_key: "followed_id",
                                  class_name: "Relationship",
                                  dependent: :destroy
 has_many :followers, through: :reverse_relationships, source: :follower

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

 def feed
  # This is preliminary. See "Following users"
  # for the full implementation
  # old code
  # Micropost.where("user_id = ?", id)
  Micropost.from_users_followed_by(self)
 end

 def following?(other_user)
  relationships.find_by(followed_id: other_user.id)
 end

 def follow!(other_user)
  relationships.create!(followed_id: other_user.id)
 end

 def unfollow!(other_user)
  relationships.find_by(followed_id: other_user.id).destroy!
 end

 private
  def create_remember_token
   self.remember_token = User.encrypt(User.new_remember_token)
  end
end
