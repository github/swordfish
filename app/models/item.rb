class Item < ActiveRecord::Base

  has_many :shares

  self.include_root_in_json = false

  def share_with(user, key)
    Share.create! :item_id => id, :user_id => user.id, :key => key
  end

  def share_for(user)
    shares.where(:user_id => user.id).first!
  end
end