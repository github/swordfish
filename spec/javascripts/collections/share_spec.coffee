#= require models

describe 'Share.Collection', ->
  beforeEach ->
    @item = {url: -> '/items/1'}
    @collection = new Share.Collection([], item: @item)

  describe 'url', ->
    it 'uses the item id', ->
      expect(@collection.url()).toEqual('/items/1/shares')
