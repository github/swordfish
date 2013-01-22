require 'spec_helper'

describe RsaChallenge do
  let(:keypair) { KeypairFactory.reserve }
  let(:public_key) { keypair.public_key }
  let(:private_key) { keypair.private_key }

  describe RsaChallenge::Request do
    subject do
      RsaChallenge::Request.new(public_key)
    end

    it 'finds user' do
      user = mock(:user)
      User.should_receive(:with_public_key).and_return(user)
      expect(subject.user).to eql(user)
    end
  end

  describe RsaChallenge::Response do
    let(:user) { double(:user, :id => next_id) }
    let(:challenge) { RsaChallenge::Request.new(public_key) }

    before do
      User.stub!(:with_public_key).and_return(user)
    end

    describe 'valid?' do
      context 'with a decrypted challenge' do
        before do
          value = Base64.decode64(challenge.value)
          @decrypted = Base64.encode64(keypair.key.private_decrypt(value))
        end

        subject do
          RsaChallenge::Response.new(@decrypted)
        end

        it 'returns true' do
          expect(subject.valid?).to be_true
        end

        it 'sets user_id' do
          expect(subject.user_id).to be_nil
          subject.valid?
          expect(subject.user_id).to eql(user.id.to_s)
        end
      end

      context 'with an invalid challenge' do
        it 'returns false' do
          response = RsaChallenge::Response.new(challenge.value)
          expect(response.valid?).to be_false
        end
      end
    end
  end
end
