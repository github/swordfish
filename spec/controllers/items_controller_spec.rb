require 'spec_helper'

describe ItemsController do
  context 'when signed in' do
    before { sign_in_as mock_user }

    describe 'create' do
      subject do
        post :create,
          :title => 'example.com',
          :data  => 'encrypted',
          :key   => 'userkey'
      end

      it { expect(subject.status).to be(201) }

      it 'creates an item' do
        subject
        expect(Item.first(:title => 'example.com')).to be_instance_of(Item)
      end
    end

    describe 'index' do
      subject do
        get :index
      end

      it { expect(subject.status).to be(200) }
    end
  end

  context 'when signed out' do
    it { expect(post(:create, :format => :json).status).to be(401) }
  end
end