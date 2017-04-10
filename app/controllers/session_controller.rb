class SessionController < ApplicationController
  skip_before_filter :sign_in_required

  def signout
    @current_user = nil
    redirect_to root_path
  end
end
