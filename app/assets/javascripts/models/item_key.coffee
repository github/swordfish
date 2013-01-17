#= require aes

class @ItemKey
  # FIXME: replace with forge
  @cipher: CryptoJS.AES
  @bytes: 64

  @generate: ->
    forge.random.getBytes(@bytes)

  constructor: (@key) ->

  encrypt: (data) ->
    @constructor.cipher.encrypt(JSON.stringify(data), @key).toString()

  decrypt: (data) ->
    result = @constructor.cipher.decrypt(data, @key)
    JSON.parse(result.toString(CryptoJS.enc.Utf8))
