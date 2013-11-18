class UsersController < ApplicationController
 # To limit other users to edit other profile
 before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
 before_action :correct_user, only: [:edit, :update]
 before_action :admin_user, only: :destroy

 def destroy
  User.find(params[:id]).destroy
  flash[:success] = "User deleted"
  redirect_to users_url
 end

 def index
  # @users = User.all
  @users = User.paginate(page: params[:page])
 end

 def new
  @user = User.new
 end

 def show
  @user = User.find(params[:id])
 end

 def create
  @user = User.new(user_params)
  if @user.save
   # Just after save, signin the user
   sign_in @user
   #handle a successful save.
   flash[:success] = "Welcome to the Sample App!"
   redirect_to @user   # This will redirect to user's show page without using user_url
  else
   render 'new'
  end
 end

 def edit
  # use correct_user method to edit
  # @user = User.find(params[:id])
 end

 def update
  # @user = User.find(params[:id])
  if @user.update_attributes(user_params)
   # Handle a successful update.
   flash[:success] = "Profile updated"
   redirect_to @user
  else
   render 'edit'
  end
 end

 #def destroy
  #User.find(params[:id].destroy
  #flash[:success] = "User deleted."
  #redirect_to users_url
 #end

  private
   # dont include admin attribute here to it would not be accessible
  # by just using
  # patch /users/17?admin=1 
  # this above line could toggle the admin attrb to true. BEWARE
   def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
   end

   # Before filters
   def signed_in_user
    unless signed_in?
     store_location
     redirect_to signin_url, notice: "Please sign in." 
    end
   end

   def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
    # current_user method located in app/helpers/session_helper.rb
   end
   
   # this protects a hacker to issue DELETE request directly from
   # the command line to delete any user on the site.
   def admin_user
    redirect_to(root_url) unless current_user.admin?
   end

end
