require 'spec_helper'

describe User do
  describe '.with_public_key' do
    context 'when the user does not exist' do
      it 'sets fingerprint before saving' do
        key = double(:key, :fingerprint => 'fingerprint', :to_s => 'key')
        user = User.with_public_key(key)
        expect(user.fingerprint).to be_present
      end
    end
  end

end