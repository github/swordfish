class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :team, :user
      t.string :key
      t.timestamps
    end
  end
end
