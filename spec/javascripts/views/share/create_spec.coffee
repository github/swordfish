#= require application
#= require ui

describe 'Share.Views.Create', ->
  beforeEach ->
    @teams = new Backbone.Collection([{id: 42, name: 'Home Team'}])
    Backbone.View.prototype.app = {teams: @teams}

    @item = {share: jasmine.createSpy('share')}

    @view = new Share.Views.Create(model: @item)
    @view.render()

  describe 'render', ->
    it 'shows teams', ->
      expect(@view.$("option[value=42]").text()).toEqual('Home Team')

  describe 'submit', ->
    beforeEach ->
      @event = {preventDefault: jasmine.createSpy('preventDefault')}
      @view.$('select[name=team]').val(42)

    it 'cancels the normal form submission', ->
      @view.submit(@event)
      expect(@event.preventDefault).toHaveBeenCalled()

    it 'shares with the team', ->
      @view.submit(@event)
      expect(@item.share).toHaveBeenCalled()
      expect(@item.share.mostRecentCall.args[0]).toEqual(@teams.first())

    it 'resets the form', ->
      @view.submit(@event)
      expect(@view.$('select[name=team]').val()).toEqual('')
