class @KeypairAuthenticator
  @ajax: jQuery.ajax

  constructor: (@keypair) ->
    jQuery.extend @, jQuery.Deferred()
    @done @setupAjax

  # Public: Request a challenge from the server.
  request: ->
    @constructor.ajax(
      type:     'POST'
      url:      '/auth/rsa'
      data:     @keypair.publicKeyPem()
      dataType: 'text'
    ).done @respond
    @

  # Internal: Respond to the challenge from the server.
  respond: (data) =>
    @challenge = @decryptChallenge(data)

    @constructor.ajax(
      type:     'PUT'
      url:      '/auth/rsa'
      dataType: 'text'
      data:     @challenge
    ).done => @resolve(@challenge)

  # Internal: Decrypt the challenge from the server.
  decryptChallenge: (challenge) ->
    forge.util.encode64(@keypair.decrypt(forge.util.decode64(challenge)))

  # Internal
  setupAjax: =>
    jQuery.ajaxPrefilter @setHeader

  # Internal
  setHeader: (options, originalOptions, xhr) =>
    xhr.setRequestHeader('X-Challenge', @challenge)
    return # return type effects dataType
