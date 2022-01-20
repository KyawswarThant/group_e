class ChefsController < ApplicationController
  before_action :chef_authorized, only: [:index, :profile, :edit_profile]

  def index
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    @is_chef_create = ChefService.create_chef(@chef)

    # check new chef is create or not
    if @is_chef_create
      redirect_to chef_login_path
    else
      render :new
    end
  end

  #update chef profile
  def update
    @chef = ChefService.getChefByID(params[:id])
    @is_chef_update = ChefService.updateChef(@chef, chef_params)
    if @is_chef_update
      redirect_to chef_profile_path
    else
      render :edit_profile
    end
  end

  def chef_profile
    @chef = ChefService.getChefByID(session[:chef_id])
  end

  def edit_profile
    @chef = ChefService.getChefByID(session[:chef_id])
  end

  #change password
  def update_password
    if params[:current_password].blank? && params[:password].blank? && params[:confirmation_password].blank?
      redirect_to password_path, notice: "password fields required"
    elsif params[:current_password].blank? && params[:password] != nil && params[:confirmation_password] != nil
      redirect_to password_path, notice: "current password required"
    elsif params[:current_password] != nil && params[:password].blank? && params[:confirmation_password] != nil
      redirect_to password_path, notice: "new password required"
    elsif params[:current_password] != nil && params[:password] != nil && params[:confirmation_password].blank?
      redirect_to password_path, notice: "confirmation password required"
    else
      @chef = ChefService.getChefByID(session[:chef_id])
      if @chef.authenticate(params[:current_password])
        if params[:password] != params[:confirmation_password]
          redirect_to password_path, notice: "comfirmation password didn't match"
        else
          @is_update_password = ChefService.updatePassword(@chef, params[:password])
          if @is_update_password
            redirect_to chef_profile_path, notice: "password change successfully"
          end
        end
      else
        redirect_to password_path, notice: "incorrect current password"
      end
    end
  end

  private

  def chef_params
    params.require(:chef).permit(:name, :email, :password, :phone, :birthday, :address)
  end
end
