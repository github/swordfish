require 'spec_helper'

describe Auth::RsaController do
  let(:public_key) { fixture('pub.pem') }
  describe 'create' do
    context 'as an existing user' do
      let(:user) { User.create!(:public_key => public_key) }

      subject do
        raw_post :create, user.public_key
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

    context 'as a new user' do
      subject do
        raw_post :create, public_key
      end

      it 'creates the user' do
        subject
        expect(User.first(:public_key => public_key)).to be_present
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
  end

  describe 'update' do
    let(:user) { User.create!(:public_key => public_key) }

    context 'with a valid response' do
      before do
        challenge = mock(:valid? => true, :user_id => user.id)
        RsaChallenge::Response.stub(:new).and_return(challenge)
      end

      subject do
        put :update, :challenge => 'valid'
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
        put :update, :challenge => "invalid"
        expect(response.status).to eq(401)
      end
    end
  end
end
