class Infobar.Save extends Backbone.TemplateView
  template: 'chrome/infobar/save'

  events:
    'submit form': 'submit'

  constructor: (options) ->
    super
    @infobar = options.infobar

  submit: =>
    name = @$('input[type=text]').val()
    @infobar.extension.save(name: name).then(@done)
    false

  done: =>
    @infobar.dismiss()