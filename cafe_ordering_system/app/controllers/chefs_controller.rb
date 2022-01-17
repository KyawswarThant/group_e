class ChefsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
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

  private
    def chef_params
      params.require(:chef).permit(:name, :email, :password, :phone, :birthday, :address)
    end
end
