class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :item_id
      t.integer :user_id
      t.string  :key
 
      t.timestamps
    end
  end
end
