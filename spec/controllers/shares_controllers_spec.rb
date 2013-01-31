require 'spec_helper'

describe SharesController do
  let(:team) { mock_model(Team, :id => next_id).as_null_object }
  let(:item) { mock_model(Item, :id => next_id).as_null_object }
  let(:key)  { 'team-item-key' }

  before do
    Team.stub! :find => team
    Item.stub! :find => item
  end

  describe 'create' do
    before { sign_in_as mock_user }

    subject do
      post :create,
        :item_id => item.id.to_s,
        :team_id => team.id.to_s,
        :key     => key
    end

    context 'when signed in' do
      it { expect(subject.status).to be(201) }

      it 'shares the item with the team' do
        item.should_receive(:share_with).with(team, key)
        subject
      end
    end

    context 'without access to the item' do
      before do
        item.stub!(:share_for).and_raise(ActiveRecord::RecordNotFound.new(1))
      end

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  context 'when signed out' do
    it { expect(post(:create, :item_id => 1, :format => :json).status).to be(401) }
  end
end
