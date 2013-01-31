class @ItemKey
  @cipher: forge.aes
  @key_size: 32

  @generate: ->
    forge.random.getBytes(@key_size)

  constructor: (@key) ->

  encrypt: (data) ->
    iv     = forge.random.getBytes 16
    cipher = @constructor.cipher.startEncrypting @key, iv
    buffer = forge.util.createBuffer(JSON.stringify(data))
    
    cipher.update buffer
    cipher.finish()
    encrypted_data = cipher.output.data

    JSON.stringify
      iv  : forge.util.encode64 iv
      data: forge.util.encode64 encrypted_data

  decrypt: (data) ->
    json_data      = JSON.parse data
    iv             = forge.util.decode64 json_data['iv']
    encrypted_data = forge.util.decode64 json_data['data']
    buffer         = forge.util.createBuffer encrypted_data

    cipher = forge.aes.startDecrypting @key, iv
    cipher.update buffer
    cipher.finish()
    JSON.parse cipher.output.data