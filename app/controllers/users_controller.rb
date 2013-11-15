class UsersController < ApplicationController
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

  private
   def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
   end
end
