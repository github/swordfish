class InvitesController < ApplicationController
  before_filter :ensure_team_admin

  def create
    invite = current_team.invite(params[:email])
    TeamMailer.invite(current_team, invite).deliver
    render :json => invite, :status => :created
  end

  def accept
    invite = Invite.from_key(params[:key])
    invite.accept(current_user)
    head :ok
  end
end
