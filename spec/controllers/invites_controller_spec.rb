require 'spec_helper'

describe InvitesController do
  let(:team) { double(:team, :id => BSON::ObjectId.new).as_null_object }
  let(:email) { 'bkeepers@github.com' }

  before do
    Team.stub! :get! => team
    team.stub! :invite => nil
  end

  context 'when signed in' do
    before { sign_in_as mock_user }

    describe 'create' do
      subject do
        post :create,
          :team_id => team.id.to_s,
          :email => email
      end

      it { expect(subject.status).to be(201) }

      it 'sends and invite' do
        team.should_receive(:invite).with(email).and_return({})
        subject
      end
    end
  end

  context 'when signed out' do
    it { expect(post(:create, :team_id => 1, :format => :json).status).to be(401) }
  end
end