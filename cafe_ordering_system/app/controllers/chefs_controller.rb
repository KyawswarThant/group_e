class ChefsController < ApplicationController
  before_action :chef_authorized, only: [:index, :profile, :edit_profile]

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
    @chef = ChefService.get_chef_by_id(params[:id])
    @is_chef_update = ChefService.update_chef(@chef, chef_params)
    if @is_chef_update
      redirect_to chef_path(id: session[:chef_id])
    else
      render :edit_profile
    end
  end

  #show chef profile
  def show
    @chef = ChefService.get_chef_by_id(params[:id])
  end

  #edit chef profile
  def edit
    @chef = ChefService.get_chef_by_id(params[:id])
  end

  #change password
  def update_password
    if params[:current_password].blank? || params[:password].blank? || params[:confirmation_password].blank?
      if params[:current_password].blank?
        @current = $CURRENT_PASSWORD_REQUIRED
      end
      if params[:password].blank?
        @new = $NEW_PASSWORD_REQUIRED
      end
      if params[:confirmation_password].blank?
        @confirm = $CONFIRM_PASSWORD_REQUIRED
      end
      render :change_password
    else
      @chef = ChefService.get_chef_by_id(session[:chef_id])
      if @chef.authenticate(params[:current_password])
        if params[:password] != params[:confirmation_password]
          @confirm = $CONFIRM_PASSWORD_VALIDATION
          render :change_password
        else
          @is_update_password = ChefService.update_password(@chef, params[:password])
          if @is_update_password
            redirect_to chef_path(id: session[:chef_id]), alert: $PASSWORD_CHANGE_SUCCESS
          end
        end
      else
        @current = $CURRENT_PASSWORD_VALIDATION
        render :change_password
      end
    end
  end

  private

  def chef_params
    params.require(:chef).permit(:name, :email, :password, :phone, :birthday, :address)
  end
end
