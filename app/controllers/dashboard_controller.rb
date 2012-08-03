class DashboardController < ApplicationController
  before_filter :sign_in_required

  def mockup
    render :layout => false
  end
end