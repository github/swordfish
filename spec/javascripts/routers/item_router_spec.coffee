#= require forge
#= require application
#= require models/keypair
#= require routers/item_router

describe 'ItemRouter', ->
  describe 'items', ->
    it 'should set the keypair on the collection if it does not exist', ->
      app = Application
      key1 = new Keypair("private1")
      app.keypair = key1
      router = new ItemRouter(app: app)
      router.items()
      expect(router.itemsCollection.keypair).toEqual(key1)

    it 'should set the keypair on the collection to the new key if it does exist', ->
      app = Application
      key1 = new Keypair("private1")
      key2 = new Keypair("private2")
      app.keypair = key1
      router = new ItemRouter(app: app)
      router.items()
      # Key1 should be set properly on the collection
      expect(router.itemsCollection.keypair).toEqual(key1)
      # Simulate the user changing keypairs
      app.keypair = key2
      router.items()
      expect(router.itemsCollection.keypair).toEqual(key2)
