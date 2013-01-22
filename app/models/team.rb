class Team < ActiveRecord::Base

  has_many :memberships

  def add(user, key)
    Membership.create! :team_id => id, :user_id => user.id, :key => key
  end

  def membership(user)
    memberships.where(:user_id => user.id).first!
  end

  def invite(email)
    Invite.create! :team_id => id, :email => email
  end

  def invites
    Invite.to(self)
  end

end
