require 'spec_helper'

describe Auth::RsaController do
  let(:public_key) { fixture('pub.pem') }

  describe 'create' do
    subject do
      raw_post :create, public_key
    end

    it 'responds with 200' do
      expect(subject).to be_success
    end

    it 'returns a challenge' do
      challenge = mock(:value => "foo")
      RsaChallenge::Request.should_receive(:new).and_return(challenge)
      expect(subject.body).to eql("foo")
    end
  end

  describe 'update' do
    let(:user) { User.create!(:public_key => public_key) }

    context 'with a valid response' do
      before do
        challenge = mock(:valid? => true, :user_id => user.id)
        RsaChallenge::Response.stub(:new).and_return(challenge)
      end

      subject do
        raw_post :update, 'valid'
      end

      it 'returns 200' do
        expect(subject).to be_success
      end
    end

    context 'with an invalid response' do
      before do
        challenge = mock(:valid? => false)
        RsaChallenge::Response.stub(:new).and_return(challenge)
      end

      subject do
        raw_post :update, 'invalid'
      end

      it 'returns 401' do
        expect(subject.status).to eq(401)
      end
    end
  end
end
