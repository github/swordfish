require '/assets/lib/jquery.js'
require '/assets/models/keypair.js'

describe 'Keypair', ->
  beforeEach ->
    Keypair.ajax = @ajax = jasmine.createSpy('ajax')
    Keypair.localStorage = @local = {}

    @keypair = new Keypair('public', 'private')

  describe 'savePublicKey', ->
    it 'saves public key to server', ->
      @keypair.savePublicKey()
      expect(@ajax).toHaveBeenCalled()

      params = @ajax.mostRecentCall.args[0]
      expect(params.url).toEqual('/key')
      expect(params.data).toEqual(@keypair.publicKey)

  describe 'savePrivateKey', ->
    it 'saves private key to local storage', ->
      @keypair.savePrivateKey()
      expect(@local['privateKey']).toEqual('private')

    it 'updates private key with provided', ->
      keypair = new Keypair('public', 'private')
      keypair.savePrivateKey('changed')
      expect(keypair.privateKey).toEqual('changed')

  describe 'load', ->
    describe 'when private key is set', ->
      beforeEach -> @local['privateKey'] = 'private'

      it 'returns keypair with public/private key', ->
        keypair = Keypair.load('public')
        expect(keypair).toBeTruthy()
        expect(keypair.privateKey).toEqual('private')
        expect(keypair.publicKey).toEqual('public')

    describe 'when private key is not set', ->
      it 'returns keypair with blank private key', ->
        keypair = Keypair.load('public')
        expect(keypair).toBeTruthy()
        expect(keypair.publicKey).toBe('public')
        expect(keypair.privateKey).toBe(undefined)

    describe 'when public key is blank', ->
      it 'returns nothing', ->
        expect(Keypair.load(undefined)).toBe(undefined)
