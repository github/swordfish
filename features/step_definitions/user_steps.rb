Given 'the following users exist:' do |table|
  table.hashes.each do |attrs|
    user = User.new
    attrs.each {|k,v| user[k.underscore] = v }
    user.public_key = KeypairFactory.reserve.public_key
    user.save!
  end
end

Given 'I am signed in as "$email"' do |email|
  user = User.first(:email => email)
  keypair = KeypairFactory.find(user.public_key)

  visit '/'
  page.execute_script "localStorage['privateKey'] = #{$private_key.to_json}"

  visit path_to('the dashboard')
  fill_in 'passphrase', :with => keypair.password
  click_button 'Unlock'
  page.should have_content('Sign Out')
end

Given 'I sign out' do
  page.execute_script "localStorage.clear()"
  click_link "Sign Out"
  page.should have_content 'Create a Key'
end