$public_key = Rails.root.join('spec', 'fixtures', 'pub.pem').read
# password == 'testing'
$private_key = Rails.root.join('spec', 'fixtures', 'priv.pem').read

Given 'I have generated a key' do
  User.create!(:public_key => $public_key)
  visit '/'
  page.execute_script "localStorage['privateKey'] = #{$private_key.to_json}"
end

Given 'I have generated and unlocked my key' do
  step 'I have generated a key'
  visit path_to('the dashboard')
  fill_in 'passphrase', :with => 'testing'
  click_button 'Unlock'
  page.should have_content('Lock')
end

When 'I generate a key' do
  fill_in 'passphrase', :with => 'testing'
  step 'I wait an eternity'
  click_button 'Generate Key'
  page.should have_content("Download")
  click_link 'Done'
  page.should have_content('Lock')
end

Then /^"Download Private Key" should contain the private key$/ do
  find('a[download="swordfish.pem"]')['href'].should =~ /BEGIN%20ENCRYPTED%20PRIVATE%20KEY/
end

