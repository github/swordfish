require 'spec_helper'

describe Authentication::OAuth do
  let :auth_hash do
    Hashie::Mash.new(
      :uid        => 1,
      :provider   => :github,
      :info       => Hashie::Mash.new(
        :nickname => 'bkeepers',
        :name     => 'Brandon Keepers',
        :email    => 'bkeepers@github.com'
      )
    )
  end

  let(:oauth) { Authentication::OAuth.new(auth_hash) }

  describe 'user' do
    context 'with a new user' do
      it 'creates user with credential' do
        expect(oauth.user).to be_instance_of(User)
        expect(oauth.user).not_to be_new_record

        expect(oauth.user).to have(1).credential
        expect(oauth.user.credentials.first).to eql(auth_hash)
      end
    end

    context 'with an existing user' do
      before do
        @user = User.create!(:credentials => [auth_hash])
      end

      it 'finds existing user' do
        expect(oauth.user).to eql(@user)
      end

      it 'updates stored credential' do
        auth_hash.info.email = 'brandon@opensoul.org'
        expect(oauth.user.credentials.first).to eql(auth_hash)
      end
    end
  end
end