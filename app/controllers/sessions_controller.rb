class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log them in and send to profile page (show)
      log_in user
      redirect_to user
    else
      # failed login message
      flash.now[:warn] = "Ruh Roh! The email and password you entered don't match our records. Please try again."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
