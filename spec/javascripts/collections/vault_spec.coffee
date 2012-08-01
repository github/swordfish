require '/assets/application.js'

describe 'Vault.Collection', ->
  beforeEach ->
    @collection = new Vault.Collection()

  describe 'create', ->
    beforeEach ->
      spyOn(jQuery, 'ajax')
      @vault = @collection.create({name: 'Bank', password: 's3cr3tz'})

    it 'sets the key', ->
      expect(@vault.get('key')).toBeTruthy()

    it 'does not set password', ->
      expect(@vault.get('password')).toBe(undefined)
