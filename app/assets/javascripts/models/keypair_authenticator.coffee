class @KeypairAuthenticator
  @ajax: jQuery.ajax

  constructor: (@keypair) ->

  request: ->
    @constructor.ajax(
      type:     'POST'
      url:      '/auth/rsa'
      data:     @keypair.publicKeyPem()
      dataType: 'text'
    ).done @respond

  respond: (data) =>
    challenge = @keypair.decrypt(forge.util.decode64(data))

    @constructor.ajax(
      type:     'PUT'
      url:      '/auth/rsa'
      dataType: 'text'
      data:     forge.util.encode64(challenge)
    )