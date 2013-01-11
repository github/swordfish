require 'spec_helper'

describe InvitesController do
  let(:team) { double(:team, :id => BSON::ObjectId.new).as_null_object }
  let(:email) { 'bkeepers@github.com' }

  before do
    Team.stub! :get! => team
  end

  context 'when signed in' do
    before { sign_in_as mock_user }

    describe 'create' do
      let(:invite) { double(:invite, :to_json => 'json') }

      before do
        team.stub! :invite => invite
        TeamMailer.stub!(:invite => double(:mailer).as_null_object)
      end

      subject do
        post :create,
          :team_id => team.id.to_s,
          :email => email
      end

      it { expect(subject.status).to be(201) }

      it 'creates an invite' do
        team.should_receive(:invite).with(email).and_return({})
        subject
      end

      it 'delivers an email' do
        TeamMailer.should_receive(:invite).with(team, invite)
        subject
      end
    end

    describe 'accept' do
      let(:invite) { double(:invite, :key => 'key', :accept => nil) }

      before do
        Invite.stub! :from_key => invite
      end

      subject do
        get :accept, :key => invite.key
      end

      it { expect(subject.status).to be(200) }

      it 'accepts the invite' do
        invite.should_receive(:accept).with(current_user)
        subject
      end
    end
  end

  context 'when signed out' do
    it { expect(post(:create, :team_id => 1, :format => :json).status).to be(401) }
  end
end