Vault.Views ?= {}

class Vault.Views.ListItem extends Backbone.View
  template: '#vault-template'
  className: 'vault'

  constructor: ->
    super
    @model.bind 'activate',   => @$el.addClass('selected')
    @model.bind 'deactivate', => @$el.removeClass('selected')

  serialize: ->
    @model.toJSON()