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
    team = Team.find(params[:id])
    membership = team.membership(current_user)
    team.update_attributes(team_params)
    render :json => TeamPresenter.new(team, membership)
  end

private

  def team_params
    params.slice(:name)
  end
end