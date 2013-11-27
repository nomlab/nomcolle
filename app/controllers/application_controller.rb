class ApplicationController < ActionController::Base
  protect_from_forgery

  prepend_before_filter :login_state_setup
  before_filter :authenticate

  def login_state_setup
    if session[:user_id]
      User.current = User.find_by_id(session[:user_id])
    else
      User.current = nil
    end
  end

  def authenticate
    return true if User.current

    session[:jumpto] = request.parameters
    redirect_to :controller => "welcome", :action => "login_form"
    return false
  end

  def set_current_user(user)
    session[:user_id] = user.id
    User.current = user
  end

  def reset_current_user
    session[:user_id] = nil
    User.current = nil
  end

end
