require '/assets/hogan.js'
require '/assets/lib/jquery.js'
require '/assets/lib/underscore.js'
require '/assets/lib/backbone.js'
require '/assets/ext/backbone.templateview.js'
require '/assets/templates/test.js'

describe 'Backbone.TemplateView', ->
  beforeEach ->
    class @TestView extends Backbone.TemplateView
      template: 'templates/test'

  it 'renders mustache template', ->
    view = new @TestView
    expect(view.render().$el.text()).toMatch(/Test Template/)