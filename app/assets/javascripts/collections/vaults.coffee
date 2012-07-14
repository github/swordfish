class @Vaults extends Backbone.Collection
  model: Vault
  url: '/vaults'
  key_size: 512
  create: (attrs) ->
    password = attrs.password
    delete attrs.password
    attrs.key = @createKey(password)
    super attrs

  createKey: (password) ->
    key = CryptoJS.lib.WordArray.random(@key_size/8).toString()
    CryptoJS.AES.encrypt(key, password).toString()
