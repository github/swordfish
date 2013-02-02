#= require models

describe 'Item', ->
  beforeEach ->
    @keypair =
      encrypt: jasmine.createSpy('encrypt').andReturn('encrypted')
      decrypt: jasmine.createSpy('decrypt').andReturn('decrypted')

    @collection = {keypair: @keypair, url:'/items'}
    spyOn(jQuery, 'ajax')
    spyOn(ItemKey, 'generate').andReturn('generated key')

  describe 'initialize', ->
    it 'generates a key', ->

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

    it 'resets shares collection', ->
      @item.set shares: [{id: 1}]
      expect(@item.shares.size()).toBe(1)

  describe 'share', ->
    beforeEach ->
      @item = new Item({id: 42, key: 'itemkey'}, collection: @collection)
      @team = new Team({id: 43}, collection: @collection)

      spyOn(@item.shares, 'create')
      spyOn(@team.key, 'encrypt').andReturn('EncryptedWithTeamKey')

      @item.share(@team)

    it 'encrypts the item key with the team key', ->
      expect(@team.key.encrypt).toHaveBeenCalledWith('decrypted')

    it 'creates a share', ->
      expect(@item.shares.create).toHaveBeenCalledWith
        key: 'EncryptedWithTeamKey',
        team_id: @team.id
