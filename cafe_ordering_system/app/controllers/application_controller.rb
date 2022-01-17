class ApplicationController < ActionController::Base

  before_action :authorized
  helper_method :current_waiter
  helper_method :current_chef
  helper_method :waiter_logged_in?
  helper_method :chef_logged_in?

  def current_waiter
    Waiter.find_by(id: session[:waiter_id])
  end

  def current_chef
    Chef.find_by(id: session[:chef_id])
  end

  def waiter_logged_in?
    !current_waiter.nil?
  end

  def chef_logged_in?
    !current_chef.nil?
  end

  def authorized
    redirect_to root_path unless waiter_logged_in? || chef_logged_in? 
  end

end
