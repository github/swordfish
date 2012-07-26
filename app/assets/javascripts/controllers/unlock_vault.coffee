class @UnlockVault extends Backbone.View
  template: '#unlock-vault-template'
  className: 'unlock-vault'

  events:
    'submit form': 'unlock'

  constructor: ->
    super
    @complete = @options.complete

  serialize: ->
    @model.toJSON()

  error: ->
    @$el.addClass('error')

  unlock: (e) =>
    if @model.key.unlock(@$('#unlock-vault-password').val())
      @complete() if @complete
    else
      @error()

    false

