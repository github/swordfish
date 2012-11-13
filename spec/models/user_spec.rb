require 'spec_helper'

describe User do
  context 'callbacks' do
    it 'sets fingerprint before saving' do
      user = User.create!(:public_key => fixture('pub.pem'))
      expect(user.fingerprint).to be_present
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