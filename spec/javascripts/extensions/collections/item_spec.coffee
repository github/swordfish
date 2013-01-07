require '/assets/lib/jquery.js'
require '/assets/models.js'

describe 'Item.Collection', ->
  beforeEach ->
    @collection = new Item.Collection([], keypair: {})

  describe 'forHost', ->
    beforeEach ->
      @item = new Item({key: 'test', host: 'example.com'})
      @collection.add @item

    it 'returns item with host', ->
      expect(@collection.forHost('example.com')).toEqual(@item)

    it 'returns undefined if none match', ->
      expect(@collection.forHost('github.com')).toBe(undefined)