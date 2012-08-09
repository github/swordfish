class UserPresenter
  def initialize(user)
    @user = user
  end

  def as_json(options = nil)
    {
      'public_key' => @user.public_key
    }
  end
end