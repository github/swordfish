#= require forge
#= require models/item_key

describe 'ItemKey', ->
  beforeEach ->
    @key = new ItemKey(ItemKey.generate())

  describe 'encrypt/decrypt', ->
    it 'encrypts and decrypts the data', ->
      expect(@key.decrypt(@key.encrypt('topsecret'))).toEqual('topsecret')
