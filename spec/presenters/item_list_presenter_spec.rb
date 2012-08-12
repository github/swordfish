require 'spec_helper'

describe ItemListPresenter do
  let(:user) { mock_user }
  subject { ItemListPresenter.new(user) }

  describe 'items' do
    let(:item) { Item.create! }

    it 'includes items shared with user' do
      item.share_with(user, 'key')
      expect(subject.items).to include(item)
    end

    it 'does not include items not shared' do
      expect(subject.items).not_to include(item)
    end
  end

  describe 'as_json' do
    let(:item) { Item.create!(:title => 'example.com') }

    before do
      item.share_with(user, 'thekey')
    end

    it 'includes item attributes' do
      item = subject.as_json.first
      expect(item['title']).to eql('example.com')
    end

    it 'includes key' do
      expect(subject.as_json.first['key']).to eql('thekey')
    end
  end
end