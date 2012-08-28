require 'spec_helper'

describe User do
  context 'callbacks' do
    it 'sets fingerprint before saving' do
      user = User.create!(:public_key => fixture('pub.pem'))
      expect(user.fingerprint).to be_present
    end
  end

end