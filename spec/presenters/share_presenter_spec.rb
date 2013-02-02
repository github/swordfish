require 'spec_helper'

describe SharePresenter do
  let(:share) { Share.new(:owner => owner) }
  subject { SharePresenter.for(share).as_json }

  context 'for a team' do
    let(:owner) { stub_model(Team, :name => 'GitHub') }

    its(['id'])      { should == share.id }
    its(['name'])    { should == owner.name }
    its(['team_id']) { should == owner.id }
  end

  context 'for a user' do
    let(:owner) { stub_model(User) }

    its(['id'])      { should == share.id }
    its(['name'])    { pending "add identifiable info to user" }
    its(['user_id']) { should == owner.id }
  end
end
