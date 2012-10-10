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
      expect { team.membership(user) }.to raise_error(Toy::NotFound)
    end
  end
end