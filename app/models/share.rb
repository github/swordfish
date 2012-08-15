class Share
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['shares']

  self.include_root_in_json = false

  attribute :item_id, BSON::ObjectId
  attribute :user_id, BSON::ObjectId
  attribute :key,     String
end