class Team
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['teams'], :safe => true

  attribute :name, String

  def add(user, key)
    Membership.create! :team_id => id, :user_id => user.id, :key => key
  end

  def membership(user)
    Membership.first(:team_id => id, :user_id => user.id) ||
      raise(Toy::NotFound, :team_id => id, :user_id => user.id)
  end

  def invite(email)
    Invite.create! :team_id => id, :email => email
  end
end