class WaitersController < ApplicationController
  before_action :waiter_authorized, only: [:index, :profile, :edit_profile]

  def index
  end

  def new
    @waiter = Waiter.new
  end

  def create
    @waiter = Waiter.new(waiter_params)
    @is_waiter_create = WaiterService.create_waiter(@waiter)

    # check new waiter is create or not
    if @is_waiter_create
      redirect_to root_path
    else
      render :new
    end
  end

  #update waiter profile
  def update
    @waiter = WaiterService.get_waiter_by_id(params[:id])
    @is_waiter_update = WaiterService.update_waiter(@waiter, waiter_params)
    if @is_waiter_update
      redirect_to waiter_profile_path
    else
      render :waiter_edit_profile
    end
  end

  #show waiter profile
  def waiter_profile
    @waiter = WaiterService.get_waiter_by_id(session[:waiter_id])
  end

  #edit waiter profile
  def waiter_edit_profile
    @waiter = WaiterService.get_waiter_by_id(session[:waiter_id])
  end

  #change waiter password
  def waiter_update_password
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
      render :waiter_change_password
    else
      @waiter = WaiterService.get_waiter_by_id(session[:waiter_id])
      if @waiter.authenticate(params[:current_password])
        if params[:password] != params[:confirmation_password]
          @confirmation = "confirmation password didn't match"
          render :waiter_change_password
        else
          @is_update_password = WaiterService.update_password(@waiter, params[:password])
          if @is_update_password
            redirect_to waiter_profile_path, alert: "password change successfully"
          end
        end
      else
        @current = "invalid current password"
        render :waiter_change_password
      end
    end
  end

  private

  def waiter_params
    params.require(:waiter).permit(:name, :email, :password, :phone, :birthday, :address)
  end
end
