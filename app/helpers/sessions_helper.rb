module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = { value: user.id,
                                           expires: 6.months.from_now.utc}
    cookies.permanent[:remember_token] = { value: user.remember_token,
                                            expires: 6.months.from_now.utc}

    # To make them permanent, replace above with this
    # cookies.permanent.signed[:user_id] = user.id
    # cookies.permanent[:remember_token] = user.remember_token
  end

  # delete the db remember and cookies
  def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
  end


  def current_user
    if (user_id = session[:user_id])
      # User is authenticated so just return them
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      # User is not logged in, get from db
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies{:remember_token})
        # User found in db and has a remember set = true
        login user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    # debugger
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

#----------------------------------------------------------------
# Used to help with redirects when a user is not logged in tries
# to edit a path that requires authentication
#----------------------------------------------------------------

  # redirect to stored location or default
  def redirect_back_or(default)
    redirect_to(session[:forarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Store the url tring to be accessed
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
