class Vault.Collection extends Backbone.Collection
  model: Vault
  url: '/vaults'

  create: (attrs, options) ->
    password = attrs.password
    delete attrs.password
    attrs.key = Key.create(password)
    super attrs, options

  createKey: (password) ->
