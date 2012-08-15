require 'spec_helper'

describe ItemPresenter do
  let(:item)      { double(:item, :id => BSON::ObjectId.new).as_null_object }
  let(:presenter) { ItemPresenter.new(item) }
end