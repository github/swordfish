When 'I wait an eternity' do
  $original_capybara_wait_time = Capybara.default_wait_time
  Capybara.default_wait_time = 60
end

When 'I debug' do
  binding.pry
end

After do
  if $original_capybara_wait_time
    Capybara.default_wait_time = $original_capybara_wait_time
    $original_capybara_wait_time = nil
  end
end
