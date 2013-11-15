module SessionsHelper
 def sign_in(user)
  remember_token = User.new_remember_token
  # cookies.permanent by default is 20 years
  cookies.permanent[:remember_token] = remember_token
  user.update_attribute(:remember_token, User.encrypt(remember_token))
  self.current_user = user
 end

 # self.current_user = user is a self assigment which
 # is converted to method current_user=(user)
 # this is a replicate of attr_accessor
 def current_user=(user)
  @current_user = user
 end

 def current_user
  remember_token = User.encrypt(cookies[:remember_token])
  # return @current_user 
  # ||= is use to assign the token only first time when current_user
  # is called, but on subsequent invocations returns @current_user
  # without hitting the database.
  # meaning if nill leaving it alone!
  @current_user ||= User.find_by(remember_token: remember_token)
 end

 def signed_in?
  !current_user.nil?
 end

 def sign_out
  self.current_user = nil
  cookies.delete(:remember_token)
 end
end
