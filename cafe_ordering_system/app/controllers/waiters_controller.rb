class WaitersController < ApplicationController
  before_action :waiter_authorized, only: [:index, :profile, :edit_profile]

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
      redirect_to waiter_path(id: session[:waiter_id])
    else
      render :waiter_edit_profile
    end
  end

  #show waiter profile
  def show
    @waiter = WaiterService.get_waiter_by_id(params[:id])
  end

  #edit waiter profile
  def edit
    @waiter = WaiterService.get_waiter_by_id(params[:id])
  end

  #change waiter password
  def waiter_update_password
    if params[:current_password].blank? || params[:password].blank? || params[:confirmation_password].blank?
      if params[:current_password].blank?
        @current = Messages::CURRENT_PASSWORD_REQUIRED
      end
      if params[:password].blank?
        @new = Messages::NEW_PASSWORD_REQUIRED
      end
      if params[:confirmation_password].blank?
        @confirm = Messages::CONFIRM_PASSWORD_REQUIRED
      end
      render :waiter_change_password
    else
      @waiter = WaiterService.get_waiter_by_id(session[:waiter_id])
      if @waiter.authenticate(params[:current_password])
        if params[:password] != params[:confirmation_password]
          @confirm = Messages::CONFIRM_PASSWORD_VALIDATION
          render :waiter_change_password
        else
          @is_update_password = WaiterService.update_password(@waiter, params[:password])
          if @is_update_password
            redirect_to @waiter, alert: Messages::PASSWORD_CHANGE_SUCCESS
          end
        end
      else
        @current = Messages::CURRENT_PASSWORD_VALIDATION
        render :waiter_change_password
      end
    end
  end

  private

  def waiter_params
    params.require(:waiter).permit(:name, :email, :password, :phone, :birthday, :address)
  end
end
