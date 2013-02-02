class @Item extends Backbone.Model
  initialize: ->
    @set 'key', @collection.keypair.encrypt(ItemKey.generate()) unless @has('key')
    @key = new ItemKey(@collection.keypair.decrypt(@get('key')))

    @shares = new Share.Collection(@get('shares') || [], item: @)
    @on 'change:shares', => @shares.reset(@get('shares'))

    @on 'change:data', @encryptData
    @encryptData()

  encryptData: ->
    if data = @get('data')
      @set 'encrypted_data', @key.encrypt(data)
      @unset 'data'

  data: ->
    @key.decrypt(@get('encrypted_data'))

  share: (team) ->
    @shares.create
      key: team.key.encrypt(@key.key),
      team_id: team.id
