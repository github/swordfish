class Item
  include Toy::Mongo
  adapter :mongo, Passwords::Application.config.mongo['items']

  self.include_root_in_json = false

  attribute :vault_id, BSON::ObjectId
  attribute :hostname, String
  attribute :username, String
  attribute :password, String
end