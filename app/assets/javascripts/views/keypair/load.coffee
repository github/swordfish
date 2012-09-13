Keypair.Views ?= {}

class Keypair.Views.Load extends Backbone.View
  template: 'templates/keypair/load'

  events:
    'change input[type=file]': 'change'

  constructor: (options) ->
    super
    @app = options.app

  change: (e) =>
    file = e.target.files[0]
    reader = new FileReader()
    reader.onload = @load
    reader.readAsText(file)

  load: (e) =>
    @app.setKeypair new Keypair(e.target.result)
    Backbone.history.navigate 'key/unlock', true

