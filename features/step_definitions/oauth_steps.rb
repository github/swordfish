OmniAuth.config.test_mode = true

Given 'I am signed in as "$email"' do |email|
  OmniAuth.config.add_mock(:github,
    :uid => $oauth_uid += 1,
    :info => {:email => email}
  )
  visit '/auth/github'
end

Given 'I am signed in to $service as:' do |service, table|
  omni_auth_with(service, table)
end

Given 'I signed up using $service as:' do |service, table|
  hash = omni_auth_with(service, table)
  Authentication::OAuth.new(hash).create
end

When 'I fail to sign in to $service' do |service|
  service = service.downcase.to_sym
  OmniAuth.config.mock_auth[service] = :invalid_credentials
  visit "/auth/#{service}"
end

$oauth_uid = 0

def omni_auth_with(service, table)
  # table hash has a default proc, which causes features to break
  attrs = {}.merge(table.hashes.first)

  omniauth = Hashie::Mash.new(
    :uid        => $oauth_uid += 1,
    :provider   => service.downcase,
    :info       => Hashie::Mash.new(
      :nickname => attrs['nickname'],
      :name     => attrs['name'],
      :email    => attrs['email']
    )
  )

  OmniAuth.config.mock_auth[service.downcase.to_sym] = omniauth

  omniauth
end

