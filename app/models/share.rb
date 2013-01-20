class Share < ActiveRecord::Base
  
  belongs_to :item
  belongs_to :user
  
  self.include_root_in_json = false

#  attribute :item_id, BSON::ObjectId
#  attribute :user_id, BSON::ObjectId
#  attribute :key,     String
end