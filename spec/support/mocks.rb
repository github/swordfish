module Mocks
  def mock_user(attrs = {})
    double(:user, user_attrs(attrs)).as_null_object
  end

  def user_attrs(attrs = {})
    {
      :id         => BSON::ObjectId,
      :public_key => double(:public_key)
    }.merge(attrs)
  end
end

RSpec.configure do |config|
  config.include Mocks
end
