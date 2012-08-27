class SessionsController < ApplicationController
  skip_before_filter :sign_in_required

  def destroy
    self.current_user = nil
    redirect_to sign_in_path
  end

end