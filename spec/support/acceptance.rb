require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.default_driver = ENV['SELENIUM'] ? :selenium : :poltergeist
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

module AcceptanceSpecHelpers
  def generate_key
    User.create!(:public_key => fixture('pub.pem'))
    visit '/'
    page.execute_script "localStorage['privateKey'] = #{fixture('priv.pem').to_json}"
  end

  def unlock_key(passphrase = 'testing')
    fill_in 'passphrase', :with => passphrase
    click_button 'Unlock'
  end

  def create_item(attrs = {})
    click_link '+'
    fill_in 'Title', :with => attrs[:title] || 'title'
    fill_in 'Username', :with => attrs[:username] || 'username'
    click_button 'Create'
  end

  def wait_forever(&block)
    wait_time = Capybara.default_wait_time
    Capybara.default_wait_time = 60
    block.call
  ensure
    Capybara.default_wait_time = wait_time
  end

  ### MATCHERS

  def be_unlocked
    have_content('+') # yeah, yeah, this sucks
  end
end

RSpec.configure do |config|
  config.include AcceptanceSpecHelpers, :capybara_feature => true
  config.after :each, :capybara_feature => true do
    page.execute_script 'localStorage.clear()'
  end

  config.before :each, :capybara_feature => true do
    DatabaseCleaner.strategy = :truncation
  end
end
