class ChefLoginController < ApplicationController
  def sign_in
    @chef = ChefService.find_by_email(params[:email])

    # check if authenticate or not
    if @chef && @chef.authenticate(params[:password])
      session[:chef_id] = @chef.id
      redirect_to chefs_path
    else
      redirect_to chef_login_path, notice: $LOGIN_ERR
    end
  end

  def sign_out
    session.clear
    redirect_to chef_login_path
  end
end
