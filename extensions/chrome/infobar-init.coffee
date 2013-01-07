#= require ./infobar

jQuery ($) ->
  window.infobar = new Infobar(
    window.location.hash.slice(1),
    $('#content')
  )
