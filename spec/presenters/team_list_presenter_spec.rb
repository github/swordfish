require 'spec_helper'

describe TeamListPresenter do
  let(:user) { mock_user }
  subject { TeamListPresenter.new(user) }

  describe 'teams' do
    let(:team) { Team.create! }

    it 'includes teams user is a member of' do
      team.add(user, 'key')
      expect(subject.teams).to include(team)
    end

    it 'does not include other teams' do
      expect(subject.teams).not_to include(team)
    end
  end

  describe 'as_json' do
    let(:team) { Team.create!(:name => 'GitHub') }

    before do
      team.add(user, 'thekey')
    end

    it 'includes team attributes' do
      team = subject.as_json.first
      expect(team['name']).to eql('GitHub')
    end

    it 'includes key' do
      expect(subject.as_json.first['key']).to eql('thekey')
    end
  end
end