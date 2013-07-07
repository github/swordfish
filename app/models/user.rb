class User < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection

  self.include_root_in_json = false

  has_many :shares
  has_many :memberships
  has_many :teams, :through => :memberships

  def self.with_public_key(key)
    where(:fingerprint => key.fingerprint).first ||
      create!(:public_key => key.to_s, :fingerprint => key.fingerprint)
  end

end
