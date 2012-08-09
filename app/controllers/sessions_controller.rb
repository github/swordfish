class SessionsController < ApplicationController
  skip_before_filter :sign_in_required, :key_required

  def create
    self.current_user = Authentication::OAuth.new(auth_hash).user
    redirect_to root_path
  end

  def destroy
    self.current_user = nil
    redirect_to sign_in_path
  end

  def failure
    flash[:error] = 'Authentication error'
    redirect_to sign_in_path
  end

protected

  def auth_hash
    request.env['omniauth.auth']
  end

end