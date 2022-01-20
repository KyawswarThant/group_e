class WaiterPasswordResetController < ApplicationController
  def create
    @waiter = Waiter.find_by(email: params[:email])
    if @waiter.present?
      waiterPasswordMailer.with(waiter: @waiter).reset.deliver_now
    end
    redirect_to root_path, notice: "We have sent reset password links to your mail"
  end

  def edit
    @waiter = Waiter.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to root_path, alert: "Your token have expired.Try Again"
  end

  def update
    @waiter = Waiter.find_signed!(params[:token], purpose: "password_reset")
    if @waiter.update(password_params)
      redirect_to root_path, alert: "Your password was reset successfully.Please login Again"
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:waiter).permit(:password)
  end
end
