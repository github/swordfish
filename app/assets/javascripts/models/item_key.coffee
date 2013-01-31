class @ItemKey
  @cipher: forge.aes
  @key_size: 256 / 8

  @generate: ->
    forge.random.getBytes(@key_size)

  constructor: (@key) ->

  encrypt: (data) ->
    iv     = forge.random.getBytes(16)
    buffer = forge.util.createBuffer(JSON.stringify(data))
    cipher = @constructor.cipher.startEncrypting(@key, iv)

    cipher.update(buffer)
    cipher.finish()
    ciphertext = cipher.output.data

    JSON.stringify
      iv  : forge.util.encode64(iv)
      data: forge.util.encode64(ciphertext)

  decrypt: (data) ->
    params     = JSON.parse(data)
    iv         = forge.util.decode64(params['iv'])
    ciphertext = forge.util.decode64(params['data'])
    buffer     = forge.util.createBuffer(ciphertext)
    cipher     = forge.aes.startDecrypting(@key, iv)

    cipher.update(buffer)
    cipher.finish()
    JSON.parse(cipher.output.data)
