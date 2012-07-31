require 'spec_helper'

describe ItemPresenter do
  let(:item)      { double(:item).as_null_object }
  let(:presenter) { ItemPresenter.new(item) }

  describe "as_json" do
    it "excludes password" do
      expect(presenter.as_json).to_not have_key('password')
    end
  end
end