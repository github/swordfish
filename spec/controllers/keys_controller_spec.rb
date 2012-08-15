require 'spec_helper'

describe KeysController do
  context 'when signed in' do
    let(:user) { mock_user }
    before { sign_in_as user }

    context 'create' do
      subject { raw_post :create, 'publickey' }

      it { expect(subject.status).to be(201) }

      it 'saves private key' do
        user.should_receive(:public_key=).with('publickey')
        user.should_receive(:save)
        subject
      end
    end
  end

  context 'when not signed in' do
    it { expect(get(:new, :format => :json).status).to be(401) }
    it { expect(post(:create, :format => :json).status).to be(401) }
  end
end