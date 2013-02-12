class @Item extends Backbone.Model
  initialize: ->
    @set 'key', @app.keypair.encrypt(ItemKey.generate()) unless @has('key')

    # FIXME: yuck
    key = @get('key')
    if typeof key == 'object'
      team = app.teams.get(key.team_id)
      key = team.key.decrypt(key.key)
    else
      key = @app.keypair.decrypt(key)
    @key = new ItemKey(key)

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
