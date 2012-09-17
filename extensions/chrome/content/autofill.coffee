class @Autofill
  constructor: (@params, @document) ->

  find: ->
    form = $(document).find('form')
    form = form.has("[name=#{name}]") for name, _ of @params
    form

  submit: ->
    form = @find()

    for name, value of @params
      form.find("[name=#{name}]").val(value)

    form.attr 'data-swordfish-disable', true

    form.submit()
