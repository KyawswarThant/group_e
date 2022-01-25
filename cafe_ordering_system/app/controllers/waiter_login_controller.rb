class WaiterLoginController < ApplicationController
  def sign_in
    @waiter = WaiterService.find_by_email(params[:email])

    # check if authenticate or not
    if @waiter && @waiter.authenticate(params[:password])
      session[:waiter_id] = @waiter.id
      puts "loggined in #{waiters_path}"
      redirect_to waiters_path
    else
      redirect_to root_path, notice: $LOGIN_ERR
    end
  end

  def sign_out
    session.clear
    redirect_to root_path
  end
end
