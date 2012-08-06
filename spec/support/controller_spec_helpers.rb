module ControllerSpecHelpers
  def sign_in_as(user)
    controller.stub(:current_user).and_return(user)
  end
end

RSpec.configure do |config|
  config.include ControllerSpecHelpers, :type => 'controller'
end
