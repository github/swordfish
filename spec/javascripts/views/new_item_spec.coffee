require '/assets/application.js'

describe 'NewItem', ->
  beforeEach ->
    @collection = {create: jasmine.createSpy('create')}
    @view = new NewItem(collection: @collection)

  describe 'submit', ->
    it 'creates an item', ->
      params = {foo: 'bar'}
      spyOn(jQuery.fn, 'serializeObject').andReturn(params)
      @view.submit()
      expect(@collection.create).toHaveBeenCalledWith(params)
