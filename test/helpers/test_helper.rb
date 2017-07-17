ENV['RAILS_ENV'] ||= 'test'



class ActiveSupport::TestCase
  fixtures :all

  # Return true if test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Log in as a particular user.
  def log_in_as(user)
    session[:user_id] = user.id
  end

  class ActionDispatch::IntegrationTest

    def log_in_as(user, password: 'password', remember_me: '1')
      post login_path, params: { session: { username: user.username,
                                            password: password,
                                            remember_me: remember_me
                                            }}
    end
  end






end
