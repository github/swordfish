require 'spec_helper'

describe SessionController do
  before { sign_in_as mock_user }

  describe 'signout' do

    subject do
      get :signout
    end

    it { expect(subject.status).to be(302) }
  end
end
