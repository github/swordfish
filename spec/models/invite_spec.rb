require 'spec_helper'

describe Invite do
  describe 'on create' do
    it 'generates a key' do
      invite = Invite.create!
      expect(invite.key).to be_present
      expect(invite.key.size).to eql(16)
    end
  end

  describe '.from_key' do
    it 'finds existing invite with key' do
      invite = Invite.create!
      expect(Invite.from_key(invite.key)).to eql(invite)
    end

    it 'raises error if not found' do
      expect { Invite.from_key('notfound') }.to raise_error(Toy::NotFound)
    end
  end

  describe 'accept' do
    let(:user) { double(:user, :id => BSON::ObjectId.new) }
    before { subject.accept(user) }

    context 'on an unaccepted invite' do
      subject { Invite.new }

      its(:user_id) { should eql(user.id) }
    end

    context 'on an accepted invite' do
      subject { Invite.new :user_id => BSON::ObjectId.new }

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
      expect(Invite.new(:user_id => BSON::ObjectId.new)).to be_accepted
    end

    it 'is false when user_id is not set' do
      expect(Invite.new(:user_id => nil)).to_not be_accepted
    end
  end
end