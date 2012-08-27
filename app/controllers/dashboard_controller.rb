class DashboardController < ApplicationController
  skip_before_filter :sign_in_required

  def index
    @user = UserPresenter.new(current_user)
  end

  def mockup
    render :layout => false
  end
end