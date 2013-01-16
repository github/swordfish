#= require models

describe 'Item', ->
  beforeEach ->
    @keypair =
      encrypt: jasmine.createSpy('encrypt').andReturn('encrypted')
      decrypt: jasmine.createSpy('decrypt').andReturn('decrypted')

    @collection = {keypair: @keypair, url:'/items'}
    spyOn(jQuery, 'ajax')

  describe 'initialize', ->
    it 'generates a key', ->
      spyOn(ItemKey, 'generate').andReturn('generated key')

      item = new Item({}, collection: @collection)
      expect(item.get('key')).toEqual('encrypted')
      expect(ItemKey.generate).toHaveBeenCalled()
      expect(@keypair.encrypt).toHaveBeenCalledWith('generated key')

    it 'does not override existing key', ->
      item = new Item({key: 'existing key'}, collection: @collection)
      expect(item.get('key')).toEqual('existing key')

  describe 'set', ->
    beforeEach ->
      spyOn(ItemKey.prototype, 'encrypt').andReturn('encrypted-data')
      @item = new Item({}, {collection: @collection})
      @item.set(data: {foo: 'bar'})

    it 'encrypts data', ->
      expect(@item.get('encrypted_data')).toEqual('encrypted-data')

    it 'clears unencrypted data', ->
      expect(@item.get('data')).toBe(undefined)
      expect(@item.toJSON().data).toBe(undefined)

