require '/assets/application.js'
require '/assets/ui.js'

describe 'Item.Views.Create', ->
  beforeEach ->
    @collection = {create: jasmine.createSpy('create')}
    @view = new Item.Views.Create(collection: @collection)
    @event = {preventDefault: jasmine.createSpy('preventDefault')}

  describe 'submit', ->
    it 'creates an item', ->
      @view.submit(@event)
      expect(@collection.create).toHaveBeenCalled()

    it 'cancels the normal form submission', ->
      @view.submit(@event)
      expect(@event.preventDefault).toHaveBeenCalled()

    it 'does not create an item if the passwords do not match', ->
      @view.passwordConfirmed = -> false
      @view.submit(@event)
      expect(@collection.create).not.toHaveBeenCalled()

    it 'cancels the normal form submission if the passwords do not match', ->
      @view.passwordConfirmed = -> false
      @view.submit(@event)
      expect(@event.preventDefault).toHaveBeenCalled()
