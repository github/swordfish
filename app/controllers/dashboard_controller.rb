class DashboardController < ApplicationController
  skip_before_filter :key_required

  def index
    @user = UserPresenter.new(current_user)
  end

  def mockup
    render :layout => false
  end
end