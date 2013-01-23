class Membership < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :team
  belongs_to :user

end
