require '/assets/lib/jquery.js'
require '/assets/forge.js'
require '/assets/models/keypair.js'

describe 'Keypair', ->
  beforeEach ->
    Keypair.ajax = @ajax = jasmine.createSpy('ajax')
    Keypair.localStorage = @local = {}

    @privateKey = fixture('priv.pem')
    @keypair = new Keypair(@privateKey)

  describe 'create', ->
    beforeEach ->
      spyOn(Keypair.prototype, 'unlock')
      spyOn(Keypair.prototype, 'savePublicKey')
      spyOn(Keypair.prototype, 'savePrivateKey')
      Keypair.create(@privateKey, 'testing')

    it 'unlocks the keypair', ->
      expect(Keypair.prototype.unlock).toHaveBeenCalledWith('testing')

    it 'saves the public key ', ->
      expect(Keypair.prototype.savePublicKey).toHaveBeenCalled()

    it 'saves the private key ', ->
      expect(Keypair.prototype.savePrivateKey).toHaveBeenCalled()

  describe 'savePublicKey', ->
    beforeEach ->
      @keypair.unlock('testing')

    it 'saves public key to server', ->
      @keypair.savePublicKey()
      expect(@ajax).toHaveBeenCalled()

      params = @ajax.mostRecentCall.args[0]
      expect(params.url).toEqual('/key')
      expect(params.data.replace(/\s/g, '')).toEqual(fixture('pub.pem').replace(/\s/g, ''))

  describe 'savePrivateKey', ->
    it 'saves private key to local storage', ->
      @keypair.savePrivateKey()
      expect(@local['privateKey']).toEqual(@privateKey)

  describe 'load', ->
    describe 'when keypair is not in local storage', ->
      it 'returns falsy', ->
        expect(Keypair.load()).not.toBeTruthy()

    describe 'when private key is set', ->
      beforeEach -> @local['privateKey'] = @privateKey

      it 'returns keypair with public/private key', ->
        keypair = Keypair.load(@privateKey)
        expect(keypair).toBeTruthy()
        expect(keypair.privateKeyPem).toBe(@privateKey)

  describe 'unlock', ->
    describe 'with the correct password', ->
      it 'returns true', ->
        expect(@keypair.unlock('testing')).toBe(true)

      it 'sets public key', ->
        @keypair.unlock('testing')
        expect(@keypair.publicKey).toBeTruthy()
        expect(@keypair.publicKey.encrypt).toBeTruthy()

    describe 'with an incorrect password', ->
      it 'returns true', ->
        expect(@keypair.unlock('wrong password')).toBe(false)
