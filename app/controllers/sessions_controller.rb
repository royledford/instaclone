class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log them in and send to profile page (show)
    else
      # failed login message
      flash.now[:warn] = "Ruh Roh! The email and password you entered don't match our records. Please try again."
      render 'new'
    end
  end

  def destroy

  end

end
