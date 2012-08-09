require 'adapter/mongo_atomic'

class User
  include Toy::Mongo
  include Toy::Mongo::AtomicUpdates
  adapter :mongo_atomic, Swordfish::Application.config.mongo['users']

  self.include_root_in_json = false

  attribute :email,       String
  attribute :credentials, Array
  attribute :vaults,      Array
  attribute :public_key,  String

  def add_vault(vault)
    hash = {'id' => vault.id}
    self[:vaults] << hash
    atomic_update '$push' => {'vaults' => hash}
  end

  def vaults
    Vault.all(:id => super.map {|v| v['id'] })
  end
end
