class Infobar.Save extends Backbone.TemplateView
  template: 'chrome/infobar/save'

  events:
    'submit form': 'submit'

  constructor: (options) ->
    super
    @infobar = options.infobar

  submit: =>
    attrs = {title: @$('input[type=text]').val()}
    @infobar.extension.save(@infobar.id, attrs).then(@done)
    false

  done: =>
    @infobar.dismiss()