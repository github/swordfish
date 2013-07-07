class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :team_id, :user_id
      t.string :email, :token
      t.timestamps
    end
  end
end
