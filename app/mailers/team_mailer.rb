class TeamMailer < ApplicationMailer
  def invite(team, invite)
    @team = team
    @invite = invite

    mail :to => invite.email,
      :subject => subject("Invitation to join #{team.name}")
  end
end
