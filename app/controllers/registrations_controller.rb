class RegistrationsController < Devise::RegistrationsController

  private
  #http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html

  def sign_up_params
    params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation, :current_password)
  end
end