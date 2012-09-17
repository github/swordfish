#= require lib/jquery
#= require lib/form2js
#= require chrome/extension
#= require chrome/content/autofill
#= require chrome/iframebar

class @Content
  keyCode: 191 # forward slash

  constructor: (@element) ->
    @bind()
    @extension = new Extension
    @extension.send 'connect'

    @extension.on 'infobar', @infobar

  bind: ->
    # Use native event handling since jQuery doesn't support capture
    @element.addEventListener 'submit', @submit, true
    @element.addEventListener 'keydown', @keydown, true

  submit: (event) =>
    unless $(event.target).attr('data-swordfish-disable')
      data = form2js(event.target, '.', true, null, true)
      @extension.send 'submit', data

  keydown: (event) =>
    if event.keyCode == @keyCode && event.metaKey
      @extension.send('autofill').then @autofill

  autofill: (params) =>
    new Autofill(params).submit() if params

  infobar: (path) =>
    new Iframebar(@extension, path)