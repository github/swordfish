class TeamsController < ApplicationController

  def index
    render :json => TeamListPresenter.new(current_user)
  end

  def create
    team = Team.create!(team_params)
    membership = team.add(current_user, params[:key])
    render :json => TeamPresenter.new(team, membership), :status => :created
  end

  def update
    team = Team.get(params[:id])
    membership = Membership.first(:user_id => current_user.id, :team_id => team.id)
    if membership
      team.update_attributes(team_params)
      render :json => TeamPresenter.new(team, membership)
    else
      head 404
    end
  end

private

  def team_params
    params.slice(:name)
  end
end