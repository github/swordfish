require 'spec_helper'

describe MembershipsController do
  let(:team) { double(:team, :id => next_id).as_null_object }
  let(:user) { double(:user, :id => next_id).as_null_object }
  let(:key)  { 'userkey' }

  before do
    Team.stub! :find => team
    User.stub! :find => user
  end

  context 'when signed in' do
    before { sign_in_as mock_user }

    describe 'create' do
      subject do
        post :create,
          :team_id => team.id.to_s,
          :user_id => user.id.to_s,
          :key     => key
      end

      it { expect(subject.status).to be(201) }

      it 'adds the user to the team' do
        team.should_receive(:add).with(user, key)
        subject
      end
    end

    describe 'destroy' do
      let(:membership) { double(:membership, :destroy => true) }
      let(:member) { double(:user, :id => next_id)}

      before do
        team.stub! :membership => membership
      end

      subject do
        delete :destroy, :team_id => team.id.to_s, :id => member.id.to_s
      end

      it { expect(subject.status).to be(200) }

      it 'destroys the membership' do
        membership.should_receive(:destroy)
        subject
      end
    end
  end

  context 'when signed out' do
    it { expect(post(:create, :team_id => 1, :format => :json).status).to be(401) }
  end
end