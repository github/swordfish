class User
  include Toy::Mongo
  include Toy::Mongo::AtomicUpdates
  adapter :mongo, Swordfish::Application.config.mongo['users']

  self.include_root_in_json = false

  attribute :credentials, Array
end