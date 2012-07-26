require '/assets/application.js'

describe 'Vaults', ->
  beforeEach ->
    @collection = new Vaults()

  describe 'create', ->
    beforeEach ->
      spyOn(jQuery, 'ajax')
      @vault = @collection.create({name: 'Bank', password: 's3cr3tz'})

    it 'sets the key', ->
      expect(@vault.get('key')).toBeTruthy()

    it 'does not set password', ->
      expect(@vault.get('password')).toBe(undefined)
