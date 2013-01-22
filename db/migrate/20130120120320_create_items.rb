class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :encrypted_data
 
      t.timestamps
    end
  end
end
