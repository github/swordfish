class ChangePublicKeyToText < ActiveRecord::Migration
  def change
    change_column :users, :public_key, :text
  end
end
