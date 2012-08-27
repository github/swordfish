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

      request = @ajax.mostRecentCall.args[0]

      expect(request.url).toEqual('/auth/rsa')
      expect(request.type).toEqual('POST')
      expect(request.data).toEqual('public key')

  describe 'respond', ->
    it 'sends decrypted challenge response to server', ->
      spyOn(@keypair, 'publicKeyPem').andReturn('public key')
      spyOn(@keypair, 'decrypt').andReturn('decrypted data')
      @authenticator.request()

      @deferred.resolve('encrypted data')

      request = @ajax.mostRecentCall.args[0]

      expect(request.url).toEqual('/auth/rsa')
      expect(request.type).toEqual('PUT')
      expect(request.data).toEqual(forge.util.encode64('decrypted data'))
