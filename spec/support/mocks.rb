module Mocks
  def mock_user(attrs = {})
    mock_model(User, user_attrs(attrs)).as_null_object
  end

  def user_attrs(attrs = {})
    {
      :id         => BSON::ObjectId.new,
      :public_key => double(:public_key)
    }.merge(attrs)
  end
end

RSpec.configure do |config|
  config.include Mocks
end
