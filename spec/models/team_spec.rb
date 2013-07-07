require 'spec_helper'

describe Item do
  let(:team) { Team.new }
  let(:user) { User.new }

  describe 'add' do
    it 'creates a membership' do
      membership = team.add(user, 'mykey')
      expect(membership).to be_instance_of(Membership)
      expect(membership).not_to be_new_record
      expect(membership.key).to eql('mykey')
    end
  end

  describe 'membership' do
    it 'returns membership for existing user' do
      membership = team.add(user, 'akey')
      expect(team.membership(user)).to eql(membership)
    end

    it 'raises error if user is not a member' do
      expect { team.membership(user) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'invite' do
    it 'creates an invite' do
      invite = team.invite('bkeepers@github.com')
      expect(invite).to be_instance_of(Invite)
      expect(invite).not_to be_new_record
      expect(invite.email).to eql('bkeepers@github.com')
    end
  end
end