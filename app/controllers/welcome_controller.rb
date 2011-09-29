class WelcomeController < ApplicationController
  skip_before_filter :authenticate
  def index
  end

  def login
    if request.get?
      flash.now[:notice] ="Please login first."
      reset_current_user
      redirect_to "/"
    elsif user = User.authenticate(params[:login_name], params[:password])
      set_current_user(user)
      flash.now[:notice] = "fukuda logined."
      redirect_to( session[:jumpto] || "/books")
    else
      flash.now[:error] = "Invalid user/password."
      reset_current_user
      redirect_to "/"
    end
  end

  def logout
    reset_current_user
    reset_session
    redirect_to "/"
  end
end
