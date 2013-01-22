require 'spec_helper'

describe Invite do
  describe 'on create' do
    it 'generates a token' do
      invite = Invite.create!
      expect(invite.token).to be_present
      expect(invite.token.size).to eql(16)
    end
  end

  describe '.from_token' do
    it 'finds existing invite with token' do
      invite = Invite.create!
      expect(Invite.from_token(invite.token)).to eql(invite)
    end

    it 'raises error if not found' do
      expect { Invite.from_token('notfound') }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'accept' do
    let(:user) { double(:user, :id => next_id) }
    before { subject.accept(user) }

    context 'on an unaccepted invite' do
      subject { Invite.new }

      its(:user_id) { should eql(user.id) }
    end

    context 'on an accepted invite' do
      subject { Invite.new :user_id => 99 }

      it 'returns false' do
        expect(subject.accept(user)).to be_false
      end

      it 'does not change user_id' do
        expect(subject.user_id).to_not eql(user.id)
      end
    end
  end

  describe 'accepted?' do
    it 'is true when user_id is set' do
      expect(Invite.new(:user_id => next_id)).to be_accepted
    end

    it 'is false when user_id is not set' do
      expect(Invite.new(:user_id => nil)).to_not be_accepted
    end
  end
end
