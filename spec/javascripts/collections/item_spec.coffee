require '/assets/application.js'

describe 'Item.Collection', ->
  beforeEach ->
    @key = {encrypt: jasmine.createSpy('encrypt')}
    @vault = {key: @key}
    @collection = new Item.Collection([], vault: @vault)

  describe 'create', ->
    beforeEach ->
      @key.encrypt.andReturn('encrypted')

      @item = @collection.create({username: 'person', password: 's3cr3tz'})

    it 'encrypts the password', ->
      expect(@key.encrypt).toHaveBeenCalledWith('s3cr3tz')
      expect(@item.get('password')).toEqual('encrypted')
