class ChefPasswordResetsController < ApplicationController
  def create
    @chef = ChefService.find_by_email(params[:email])

    if @chef.present?
      ChefPasswordMailer.with(chef: @chef).reset.deliver_now
    end
    redirect_to root_path, notice: "We have sent reset password links to your mail"
  end

  def edit
    @chef = Chef.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to root_path, alert: "Your token have expired.Try Again"
  end

  def update
    @chef = Chef.find_signed!(params[:token], purpose: "password_reset")

    if @chef.update(password_params)
      redirect_to root_path, alert: "Your password was reset successfully.Please login Again"
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:chef).permit(:password)
  end
end
