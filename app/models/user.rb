require 'adapter/mongo_atomic'

class User
  include Toy::Mongo
  include Toy::Mongo::AtomicUpdates
  adapter :mongo_atomic, Swordfish::Application.config.mongo['users']

  self.include_root_in_json = false

  attribute :public_key,  String
end
