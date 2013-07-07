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
      data:     @keypair.publicKey.pem()
      dataType: 'text'
    ).done @respond
    @

  # Internal: Respond to the challenge from the server.
  respond: (challenge) =>
    @challenge = @decryptChallenge(challenge)

    @constructor.ajax(
      type:     'PUT'
      url:      '/auth/rsa'
      dataType: 'text'
      data:     @challenge
    ).done => @resolve(@challenge)

  # Internal: Decrypt the challenge from the server.
  decryptChallenge: (challenge) ->
    forge.util.encode64(@keypair.decrypt(challenge))

  # Internal
  setupAjax: =>
    jQuery.ajaxPrefilter @setHeader

  # Internal
  setHeader: (options, originalOptions, xhr) =>
    xhr.setRequestHeader('X-Challenge', @challenge)
