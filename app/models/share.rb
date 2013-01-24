class Share < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :item
  belongs_to :user

  self.include_root_in_json = false

end
