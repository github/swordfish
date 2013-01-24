#= require jquery
#= require forge
#= require models/keypair

describe 'Keypair', ->
  beforeEach ->
    Keypair.ajax = @ajax = jasmine.createSpy('ajax')
    Keypair.localStorage = @local = {}

    @privateKey = readFixtures('priv.pem.txt')
    @keypair = new Keypair(@privateKey)

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
      it 'returns false', ->
        expect(@keypair.unlock('wrong password')).toBe(false)
