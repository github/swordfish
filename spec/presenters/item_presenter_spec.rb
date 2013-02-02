require 'spec_helper'

describe ItemPresenter do
  let(:item) { double(:item, :id => next_id).as_null_object }
  let(:share) { double(:share, :id => next_id).as_null_object }
  subject { ItemPresenter.new(item, share).as_json }

  it { should have_key('shares') }
end
