class @Item extends Backbone.Model
  initialize: ->
    _.extend @, new Backbone.Picky.Selectable(@)
    @set 'key', @collection.keypair.encrypt(ItemKey.generate()) unless @has('key')
    @on 'change:data', @encryptData
    @encryptData()

  encryptData: ->
    if data = @get('data')
      @set 'encrypted_data', @key().encrypt(data)
      @unset 'data'

  key: ->
    new ItemKey(@collection.keypair.decrypt(@get('key')))

  data: ->
    @key().decrypt(@get('encrypted_data'))
