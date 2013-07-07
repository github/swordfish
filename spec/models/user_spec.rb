require 'spec_helper'

describe User do
  describe '.with_public_key' do
    context 'when the user does not exist' do
      it 'sets fingerprint before saving' do
        key = double(:key, :fingerprint => 'fingerprint', :to_s => 'key')
        user = User.with_public_key(key)
        expect(user.fingerprint).to be_present
      end
    end
  end

  context 'team_ids' do
    let!(:user) { User.new }
    let!(:team) { Team.create! }

    it 'includes teams that the user is a member of' do
      team.add user, 'userkey'
      expect(user.team_ids).to include(team.id)
    end

    it 'exludes other teams' do
      expect(user.team_ids).not_to include(team.id)
    end
  end

end