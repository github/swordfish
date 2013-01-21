class User < ActiveRecord::Base
  
  has_many :shares
  
  self.include_root_in_json = false

  before_create :set_fingerprint

private

  def set_fingerprint
    self.fingerprint = OpenSSL::PKey::RSA.new(public_key).fingerprint
  end

end
