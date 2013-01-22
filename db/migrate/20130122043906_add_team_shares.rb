class AddTeamShares < ActiveRecord::Migration
  def change
    change_table :shares do |t|
      t.rename :user_id, :owner_id
      t.string :owner_type
    end

    execute "UPDATE shares SET owner_type = 'User'"
  end
end
