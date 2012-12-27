class InvitesController < ApplicationController
  before_filter :ensure_team_admin

  def create
    invite = current_team.invite(params[:email])
    render :json => invite, :status => :created
  end
end
