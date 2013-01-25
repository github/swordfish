class @User extends Backbone.Model
  publicKey: ->
    forge.pki.publicKeyFromPem @get('public_key')
