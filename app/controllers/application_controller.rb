class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :sign_in_required

private

  def sign_in_required
    unless signed_in?
      respond_to do |f|
        f.html { redirect_to sign_in_path }
        f.any  { head 401 }
      end
    end
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
