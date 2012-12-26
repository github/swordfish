require 'spec_helper'

describe UsersController do
  before { sign_in_as mock_user }

  describe 'index' do
    let(:email) { 'bkeepers@github.com' }

    subject do
      get :lookup, :email => email
    end

    context 'when a user is found' do
      let(:user) { double :email => email, :to_json => 'json' }
      before { User.stub! :find_by_email! => user }

      its(:status) { should be(200) }
      its(:body) { should eql(user.to_json)}
    end

    context 'when a user is not found' do
      its(:status) { should be(404) }
    end
  end
end