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
end