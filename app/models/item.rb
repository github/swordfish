class Item < ActiveRecord::Base

  has_many :shares

  self.include_root_in_json = false

  def share_with(owner, key)
    Share.create! :item => self, :owner => owner, :key => key
  end

  def share_for(user)
    Share.owned_by(user).first!
  end

end
