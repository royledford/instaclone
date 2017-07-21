class AccountActivationsController < ApplicationController

  def edit
    if user && !user.activated? && user.authenticated?(:activation, params:id)
      user.activate
      log_in user
      flash[:success] = "You account has been activated."
      redirect_to user
    else
      flash[:danger] = "Invalid activation. Please check your email for the correct link."
      redirect_to login_path
  end


end
