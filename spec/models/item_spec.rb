require 'spec_helper'

describe Item do
  let(:item) { Item.new }
  let(:user) { User.new }

  describe 'share_with' do
    it 'creates a share' do
      share = item.share_with(user, 'mykey')
      expect(share).to be_instance_of(Share)
      expect(share).not_to be_new_record
      expect(share.key).to eql('mykey')
    end
  end
end