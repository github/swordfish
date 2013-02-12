class @User extends Backbone.Model
  publicKey: ->
    PublicKey.fromPem(@get('public_key'))
