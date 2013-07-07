require 'spec_helper'

describe TeamsController do
  context 'when signed in' do
    before { sign_in_as mock_user }

    describe 'create' do
      subject do
        post :create,
          :name => 'GitHub',
          :key  => 'userkey'
      end

      it { expect(subject.status).to be(201) }

      it 'creates a team' do
        subject
        expect(Team.where(:name => 'GitHub').first).to be_instance_of(Team)
      end
    end

    describe 'index' do
      subject do
        get :index
      end

      it { expect(subject.status).to be(200) }
    end

    describe 'update' do
      let(:team) { Team.create! }

      subject do
        put :update, :id => team.id.to_s, :name => 'Updated'
      end

      context 'when user has access' do
        before do
          team.add current_user, 'key'
        end

        it { expect(subject.status).to be(200) }

        it 'updates team' do
          subject
          team.reload
          expect(team.name).to eql('Updated')
        end
      end

      context 'when user does not have access' do
        it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end
  end

  context 'when signed out' do
    it { expect(post(:create, :format => :json).status).to be(401) }
  end
end