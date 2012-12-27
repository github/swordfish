class Invite
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['invites']

  attribute :team_id, BSON::ObjectId
  attribute :email, BSON::ObjectId
end