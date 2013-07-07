class InvitesController < ApplicationController
  before_filter :ensure_team_admin, :except => :accept

  # /teams/:team_id/invites
  def create
    invite = current_team.invite(params[:email])
    TeamMailer.invite(current_team, invite).deliver
    render :json => InvitePresenter.new(invite), :status => :created
  end

  # /teams/:team_id/invites/:id/fulfill
  def fulfill
    invite = current_team.invites.find(params[:id])
    invite.fulfill(params[:key])
    head :ok
  end

  # /invites/:token
  def accept
    invite = Invite.from_token(params[:token])
    invite.accept(current_user)
    head :ok
  end

end
