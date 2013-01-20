require "spec_helper"

describe TeamMailer do
  describe 'invite' do
    let(:team) { double(:name => 'GitHub') }
    let(:invite) { Invite.new(:email => 'bkeepers@github.com', :token => 'token') }

    subject { TeamMailer.invite(team, invite) }

    its(:to) { should include(invite.email) }
    its(:subject) { should eql("[Swordfish] Invitation to join #{team.name}") }

    its(:body) { should include(accept_invite_path(invite.token)) }
    its(:body) { should match(/#{invite.token}/) }
  end
end
