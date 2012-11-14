require '/assets/application.js'

describe 'Item.Views.New', ->
  beforeEach ->
    @collection = {create: jasmine.createSpy('create')}
    @view = new Item.Views.New(collection: @collection)
    @event = {preventDefault: jasmine.createSpy('preventDefault')}

  describe 'submit', ->
    it 'creates an item', ->
      @view.submit(@event)
      expect(@collection.create).toHaveBeenCalled()

    it 'cancels the normal form submission', ->
      @view.submit(@event)
      expect(@event.preventDefault).toHaveBeenCalled()
