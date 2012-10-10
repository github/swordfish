class Team
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['teams']

  attribute :name, String

  def add(user, key)
    Membership.create! :team_id => id, :user_id => user.id, :key => key
  end
end