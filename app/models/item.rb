class Item
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['items']

  self.include_root_in_json = false

  attribute :title, String
  attribute :encrypted_data, String

  def share_with(object, key)
    foreign_key = "#{object.class.model_name.singular}_id"
    Share.create! :item_id => id, foreign_key => object.id, :key => key
  end

  def share_for(user)
    Share.first(:user_id => user.id) ||
      Share.first(:team_id => user.team_ids) ||
      raise(Toy::NotFound, :id => id, :user_id => user.id)
  end
end