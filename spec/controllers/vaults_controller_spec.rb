require 'spec_helper'

describe VaultsController do
  context 'with a public key' do
    before do
      sign_in_as mock_user
    end

    describe 'create' do
      it 'renders json' do
        post :create, :name => 'Honeypot', :key => 'abc123'
        json = JSON.parse(response.body)
        expect(json['name']).to eq('Honeypot')
        expect(json['key']).to eq('abc123')
      end
    end
  end

  context 'without a public key' do
    before do
      sign_in_as mock_user(:public_key => nil)
    end

    describe 'create' do
      subject do
        post :create
      end

      it { expect(subject.status).to eq(412) }
      it { expect(subject.location).to eq(key_path) }
    end
  end
end