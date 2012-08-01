require 'spec_helper'

describe SecureItemPresenter do
  let(:item)      { double(:item).as_null_object }
  let(:presenter) { SecureItemPresenter.new(item) }

  describe "as_json" do
    it "includes password" do
      expect(presenter.as_json).to have_key('password')
    end
  end
end