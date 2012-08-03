class ApplicationController < ActionController::Base
  protect_from_forgery

private

  def sign_in_required
    redirect_to sign_in_path unless signed_in?
  end

  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    session[:user_id] = user ? user.id : nil
    @current_user = user
  end
end
