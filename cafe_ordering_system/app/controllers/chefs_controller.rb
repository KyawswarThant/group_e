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

  #show chef profile
  def chef_profile
    @chef = ChefService.getChefByID(session[:chef_id])
  end

  #edit chef profile
  def edit_profile
    @chef = ChefService.getChefByID(session[:chef_id])
  end

  #change password
  def update_password
    if params[:current_password].blank? || params[:password].blank? || params[:confirmation_password].blank?
      if params[:current_password].blank?
        @current = "current password is required"
      end
      if params[:password].blank?
        @new = "new password is required"
      end
      if params[:confirmation_password].blank?
        @confirm = "confirm password is required"
      end
      render :change_password
    else
      @chef = ChefService.getChefByID(session[:chef_id])
      if @chef.authenticate(params[:current_password])
        if params[:password] != params[:confirmation_password]
          @confirmation = "confirmation password didn't match"
          render :change_password
        else
          @is_update_password = ChefService.updatePassword(@chef, params[:password])
          if @is_update_password
            redirect_to chef_profile_path, alert: "password change successfully"
          end
        end
      else
        @current = "invalid current password"
        render :change_password
      end
    end
  end

  private

  def chef_params
    params.require(:chef).permit(:name, :email, :password, :phone, :birthday, :address)
  end
end
