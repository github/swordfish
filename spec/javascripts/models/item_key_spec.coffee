require '/assets/forge.js'
require '/assets/models/item_key.js'

describe 'ItemKey', ->
  beforeEach ->
    @key = new ItemKey(ItemKey.generate())

  describe 'encrypt/decrypt', ->
    it 'encrypts and decrypts the data', ->
      expect(@key.decrypt(@key.encrypt('topsecret'))).toEqual('topsecret')
