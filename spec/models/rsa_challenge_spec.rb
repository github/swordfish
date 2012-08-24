require 'spec_helper'

describe RsaChallenge do
  let(:user) { User.create!(:public_key => fixture('pub.pem')) }

  describe RsaChallenge::Response do
    let(:challenge) { RsaChallenge::Request.new(user) }

    describe 'valid?' do
      context 'with a decrypted challenge' do
        before do
          priv = OpenSSL::PKey::RSA.new(fixture('priv.pem'), 'testing')
          @decrypted = priv.private_decrypt(challenge.value)
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