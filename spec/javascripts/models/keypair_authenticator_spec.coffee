require '/assets/lib/jquery.js'
require '/assets/forge.js'
require '/assets/models/keypair.js'
require '/assets/models/keypair_authenticator.js'

describe 'KeypairAuthenticator', ->
  beforeEach ->
    @deferred = jQuery.Deferred()
    KeypairAuthenticator.ajax = @ajax = jasmine.createSpy('ajax').andReturn(@deferred)
    @keypair = new Keypair("key")
    @authenticator = new KeypairAuthenticator(@keypair)

  describe 'request', ->
    it 'gets challenge from the server', ->
      spyOn(@keypair, 'publicKeyPem').andReturn('public key')
      @authenticator.request()
      expect(@ajax).toHaveBeenCalledWith(
        type: 'POST'
        url: '/auth/rsa'
        data: 'public key'
      )

  describe 'respond', ->
    it 'sends decrypted challenge response to server', ->
      spyOn(@keypair, 'publicKeyPem').andReturn('public key')
      spyOn(@keypair, 'decrypt').andReturn('decrypted data')
      @authenticator.request()
      @deferred.resolve("something")
      expect(@ajax).toHaveBeenCalledWith(
        type: 'PUT'
        url: '/auth/rsa'
        data: 'decrypted data'
      )

