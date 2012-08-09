require 'spec_helper'

describe UserPresenter do
  let(:user) { mock_user }
  subject { UserPresenter.new(user) }

  describe 'to_json' do
    it 'includes public_key' do
      expect(subject.as_json).to have_key('public_key')
    end
  end
end