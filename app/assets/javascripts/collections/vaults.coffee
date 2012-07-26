class @Vaults extends Backbone.Collection
  model: Vault
  url: '/vaults'

  create: (attrs) ->
    password = attrs.password
    delete attrs.password
    attrs.key = Key.create(password)
    super attrs

  createKey: (password) ->

  load: (id, callback) ->
    if record = @get(id)
      callback(record)
    else
      finder = =>
        @off 'reset', finder
        callback(@get(id))
      @on 'reset', finder
