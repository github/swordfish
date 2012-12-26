class UsersController < ApplicationController
  def lookup
    render :json => User.find_by_email!(params[:email])
  end
end
