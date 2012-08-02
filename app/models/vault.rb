class Vault
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['vaults']

  self.include_root_in_json = false

  attribute :name, String
  attribute :key,  String

  attribute :items_id, String
  attribute :items_key, String
end