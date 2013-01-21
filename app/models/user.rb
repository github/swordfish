class User < ActiveRecord::Base

  has_many :shares

  self.include_root_in_json = false

  def self.with_public_key(key)
    where(:fingerprint => key.fingerprint).first ||
      create!(:public_key => key.to_s, :fingerprint => key.fingerprint)
  end

end
