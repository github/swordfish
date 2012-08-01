class @Key
  @cipher: CryptoJS.AES
  @keySize: 512

  @create: (password) ->
    key = CryptoJS.lib.WordArray.random(@keySize/8).toString()
    @cipher.encrypt(key, password).toString()

  constructor: (@encrypted) ->

  isUnlocked: ->
    @decrypted? && @decrypted != ""

  unlock: (password) ->
    result = @constructor.cipher.decrypt(@encrypted, password)
    if result.sigBytes == @constructor.keySize / 4
      @decrypted = result.toString(CryptoJS.enc.Utf8)
    @isUnlocked()

  encrypt: (data) ->
    @constructor.cipher.encrypt(data, @decrypted).toString()

  decrypt: (data) ->
    result = @constructor.cipher.decrypt(data, @decrypted)
    result.toString(CryptoJS.enc.Utf8)
