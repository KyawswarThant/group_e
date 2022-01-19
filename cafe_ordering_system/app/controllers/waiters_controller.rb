class WaitersController < ApplicationController

  before_action :waiter_authorized, only: [:index]

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

  private
    def waiter_params
      params.require(:waiter).permit(:name, :email, :password, :phone, :birthday, :address)
    end
end
