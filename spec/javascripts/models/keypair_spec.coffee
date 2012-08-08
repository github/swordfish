require '/assets/lib/jquery.js'
require '/assets/models/keypair.js'

describe 'Keypair', ->
  beforeEach ->
    Keypair.prototype.ajax = @ajax = jasmine.createSpy('ajax')
    Keypair.prototype.localStorage = @local = {}

  describe 'save', ->
    beforeEach ->
      @keypair = new Keypair('public', 'private')

    it 'saves private key to local storage', ->
      @keypair.save()
      expect(@local['key']).toEqual('private')

    it 'saves public key to server', ->
      @keypair.save()
      expect(@ajax).toHaveBeenCalled()

      params = @ajax.mostRecentCall.args[0]
      expect(params.url).toEqual('/key')
      expect(params.data).toEqual(@keypair.publicKey)
