class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :public_key
      t.string :fingerprint
 
      t.timestamps
    end
  end
end
