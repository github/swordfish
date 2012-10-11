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
  page.should have_content('Sign Out')
end

Then /^"Download Private Key" should contain the private key$/ do
  find('a[download="swordfish.pem"]')['href'].should =~ /BEGIN%20ENCRYPTED%20PRIVATE%20KEY/
end

