module ControllerSpecHelpers
  attr_reader :current_user

  def sign_in_as(user)
    controller.stub(:current_user).and_return(user)
    @current_user = user
  end

  def raw_post(action, body)
    request.env['RAW_POST_DATA'] = body
    post action
  end

end

RSpec.configure do |config|
  config.include ControllerSpecHelpers, :type => 'controller'
end
