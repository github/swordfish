require '/assets/application.js'

describe 'Item.Views.New', ->
  beforeEach ->
    @collection = {create: jasmine.createSpy('create')}
    @view = new Item.Views.New(collection: @collection)

  describe 'submit', ->
    it 'creates an item', ->
      @view.submit()
      expect(@collection.create).toHaveBeenCalled()
