class Item < ActiveRecord::Base
  
  has_one :share
  
  self.include_root_in_json = false

#  attribute :title, String
#  attribute :encrypted_data, String

  def share_with(user, key)
    Share.create! :item_id => id, :user_id => user.id, :key => key
  end
end