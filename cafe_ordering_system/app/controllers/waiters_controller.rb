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

  def update
    @waiter = WaiterService.getWaiterByID(params[:id])
    @is_waiter_update = WaiterService.updateWaiter(@waiter, waiter_params)
    if @is_waiter_update
      redirect_to waiter_profile_path
    else
      render :waiter_edit_profile
      # render :waiter_profile
    end
  end

  def waiter_profile
    @waiter = WaiterService.getWaiterByID(session[:waiter_id])
  end

  def waiter_edit_profile
    @waiter = WaiterService.getWaiterByID(session[:waiter_id])
  end

  def waiter_update_password
    if params[:current_password].blank? && params[:password].blank? && params[:confirmation_password].blank?
      redirect_to password_path, notice: "password fields required"
    elsif params[:current_password].blank? && params[:password] != nil && params[:confirmation_password] != nil
      redirect_to password_path, notice: "current password required"
    elsif params[:current_password] != nil && params[:password].blank? && params[:confirmation_password] != nil
      redirect_to password_path, notice: "new password required"
    elsif params[:current_password] != nil && params[:password] != nil && params[:confirmation_password].blank?
      redirect_to password_path, notice: "confirmation password required"
    else
      @waiter = WaiterService.getWaiterByID(session[:waiter_id])
      if @waiter.authenticate(params[:current_password])
        if params[:password] != params[:confirmation_password]
          redirect_to password_path, notice: "comfirmation password didn't match"
        else
          @is_update_password = WaiterService.updatePassword(@waiter, params[:password])
          if @is_update_password
            redirect_to waiter_profile_path, notice: "password change successfully"
          end
        end
      else
        redirect_to password_path, notice: "incorrect current password"
      end
    end
  end

  private

  def waiter_params
    params.require(:waiter).permit(:name, :email, :password, :phone, :birthday, :address)
  end
end
