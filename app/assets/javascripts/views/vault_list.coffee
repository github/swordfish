class @VaultList extends Backbone.View
  constructor: ->
    super
    @collection.on 'add',   @add
    @collection.on 'reset', @reset
    @collection.fetch()

  reset: =>
    @$el.empty()
    @collection.each (vault) => @add(vault)

  add: (vault) =>
    @$el.append(@template(vault))

  template: (vault) =>
    # fixme: do this right
    Mustache.render $('#vault-template').text(), vault.toJSON()