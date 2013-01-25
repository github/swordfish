require 'spec_helper'

describe InvitePresenter do
  let(:invite) do
    double(:user,
      :id => 1,
      :email => 'foo@bar.com',
      :accepted? => true,
      :user => User.new
    )
  end

  subject do
    InvitePresenter.new(invite)
  end

  context 'with an accepted invite' do
    it 'includes the user' do
      expect(subject.as_json).to have_key('user')
    end
  end
end