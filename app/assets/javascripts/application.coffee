#= require lib/jquery
#= require lib/underscore
#= require lib/backbone
#= require_tree ./lib
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./controllers
#= require_tree ./views
#= require_self

class @Application
  constructor: ->
    @vaults = new Vaults();

    new CreateVault collection: @vaults, el: $('#create-vault')
    new VaultList   collection: @vaults, el: $('#vaults')
