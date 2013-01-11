class Share
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['shares'], :safe => true

  self.include_root_in_json = false

  attribute :item_id, BSON::ObjectId
  attribute :key,     String

  attribute :user_id, BSON::ObjectId
  attribute :team_id, BSON::ObjectId
end
