class Vault
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['vaults']

  self.include_root_in_json = false

  attribute :name, String
  attribute :key,  String
end