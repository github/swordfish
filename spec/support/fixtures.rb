module FixtureSpecHelper
  def fixture(name)
    Rails.root.join('spec', 'fixtures', name).read
  end
end

RSpec.configure do |config|
  config.include FixtureSpecHelper
end
