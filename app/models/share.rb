class Share < ActiveRecord::Base

  belongs_to :item
  belongs_to :owner, :polymorphic => true

  self.include_root_in_json = false

  def self.owned_by(user)
    where(
      "(owner_id = ? AND owner_type = ?) OR (owner_id in (?) AND owner_type = ?)",
      user.id, 'User', user.team_ids, 'Team'
    )
  end

end
