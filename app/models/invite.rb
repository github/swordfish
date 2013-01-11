class Invite
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['invites'], :safe => true

  attribute :team_id, BSON::ObjectId
  attribute :email,   String
  attribute :key,     String
  attribute :user_id, BSON::ObjectId

  before_create do
    self.key = SecureRandom.urlsafe_base64(12)
  end

  def self.from_key(key)
    first(:key => key) || raise(Toy::NotFound, "key=#{key}")
  end

  def self.to(team)
    all :team_id => team.id
  end

  def accept(user)
    !accepted? && update_attributes(:user_id => user.id)
  end

  def accepted?
    user_id?
  end
end
