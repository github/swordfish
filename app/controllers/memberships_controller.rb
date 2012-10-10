class MembershipsController < ApplicationController
  before_filter :ensure_team_admin

  def create
    user = User.get!(params[:user_id])
    @team.add(user, params[:key])
    render :json => {}, :status => :created
  end

  def destroy
    membership = @team.membership(User.get!(params[:id]))
    membership.destroy
    head :ok
  end

private

  def ensure_team_admin
    @team = Team.get!(params[:team_id])
    @membership = @team.membership(current_user)
  end

end
