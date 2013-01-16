require '/assets/jquery.js'
require '/assets/underscore.js'
require '/assets/forge.js'
require '/assets/models/keypair.js'
require '/assets/models/keypair_authenticator.js'

describe 'KeypairAuthenticator', ->
  beforeEach ->
    @deferred = jQuery.Deferred()
    KeypairAuthenticator.ajax = @ajax = jasmine.createSpy('ajax').andReturn(@deferred)

    @keypair = new Keypair("key")
    spyOn(@keypair, 'publicKeyPem').andReturn('public key')

    @authenticator = new KeypairAuthenticator(@keypair)
    spyOn(@authenticator, 'decryptChallenge').andReturn('decrypted challenge')

  describe 'request', ->
    it 'gets challenge from the server', ->
      @authenticator.request()

      request = @ajax.mostRecentCall.args[0]

      expect(request.url).toEqual('/auth/rsa')
      expect(request.type).toEqual('POST')
      expect(request.data).toEqual('public key')

    it 'returns authenticator', ->
      expect(@authenticator.request()).toBe(@authenticator)

  describe 'respond', ->
    it 'sends decrypted challenge response to server', ->
      @authenticator.request()
      @deferred.resolve('encrypted data')

      request = @ajax.mostRecentCall.args[0]

      expect(request.url).toEqual('/auth/rsa')
      expect(request.type).toEqual('PUT')
      expect(request.data).toEqual('decrypted challenge')

    it 'resolves with successful challenge', ->
      callback = jasmine.createSpy('done callback')
      @authenticator.done callback
      @authenticator.request()
      @deferred.resolve()

      expect(callback).toHaveBeenCalledWith('decrypted challenge')
