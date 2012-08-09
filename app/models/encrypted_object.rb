require 'digest/sha1'

class ContentAddressableKeyFactory < Toy::Identity::AbstractKeyFactory
  def key_type
    String
  end

  def next_key(object)
  	Digest::SHA1.hexdigest(object.data)
  end
end

class EncryptedObject
  include Toy::Mongo

  adapter :mongo, Swordfish::Application.config.mongo['objects']

  key ContentAddressableKeyFactory.new

  self.include_root_in_json = false

  attribute :data, String
end
