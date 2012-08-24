require 'spec_helper'

describe Auth::RsaController do
  let(:user) { User.create!(:public_key => fixture('pub.pem')) }

  describe 'show' do
    it 'responds with 200' do
      get :show, :public_key => user.public_key
      expect(response).to be_success
    end

    it 'returns a challenge' do
      challenge = mock(:value => "foo")
      RsaChallenge::Request.should_receive(:new).and_return(challenge)
      get :show, :public_key => user.public_key
      expect(response.body).to eql("foo")
    end
  end

  describe 'create' do

    context 'with a valid response' do
      before do
        challenge = mock(:valid? => true, :user_id => user.id)
        RsaChallenge::Response.stub(:new).and_return(challenge)
      end

      subject do
        post :create, :challenge => 'valid'
      end

      it 'returns 200' do
        expect(subject).to be_success
      end

      it 'signs user in' do
        subject
        expect(controller.send(:current_user)).to eql(user)
      end
    end

    context 'with an invalid response' do
      before do
        challenge = mock(:valid? => false)
        RsaChallenge::Response.stub(:new).and_return(challenge)
      end

      it 'does not log in a user without a valid challenge response' do
        post :create, :challenge => "invalid"
        expect(response.status).to eq(401)
      end
    end
  end
end
