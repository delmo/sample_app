class SessionsController < ApplicationController
 def new
 end

 def create
  user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
   # sign the user in and redirect to the user's show page.
   sign_in user
   redirect_to user
  else
   flash.now[:error] = 'Invalid email/password combination' 
   # flash.now to exist only in one page!
   render 'new'
  end
 end

 def destroy 
  sign_out
  redirect_to root_url
 end

end
