#= require jquery
#= require underscore
#= require forge
#= require models/keypair
#= require models/keypair_authenticator

describe 'KeypairAuthenticator', ->
  beforeEach ->
    @deferred = jQuery.Deferred()
    KeypairAuthenticator.ajax = @ajax = jasmine.createSpy('ajax').andReturn(@deferred)

    @keypair =
      publicKey:
        pem: jasmine.createSpy().andReturn('public key')

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
