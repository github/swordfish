#= require jquery

$(document).on 'keypress', (e) ->
  if e.keyCode == 96
    $(document.body).toggleClass('grid')

$ ->
  $('body').append('<div id="grid"></div>');
