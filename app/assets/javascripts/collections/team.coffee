class Team.Collection extends Backbone.Collection
  model: Team
  url: '/teams'

  constructor: (models, options) ->
    @keypair = options.keypair
    super
