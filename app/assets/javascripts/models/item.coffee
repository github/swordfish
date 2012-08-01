@Model ?= {}

class @Model.Item extends Backbone.Model
  reveal: ->
    @fetch()