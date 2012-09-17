require '/assets/chromemock.js'
require '/assets/chrome/background.js'

describe 'Chrome background script', ->
  beforeEach ->
    Keypair.localStorage = @local = {}
    @sender =
      tab:
        id: '123'
        url: 'http://example.com/signin'

  describe 'without a keypair', ->
    beforeEach ->
      @background = new Background()

    describe 'key', ->
      it 'saves key in localStorage', ->
        @background.key('key')
        expect(@local['privateKey']).toEqual('key')

      it 'does not override existing key', ->
        @background.key('existing')
        @background.key('changed')
        expect(@local['privateKey']).toEqual('existing')

  describe 'with a keypair', ->
    beforeEach ->
      @keypair = new Keypair('key')
      @background = new Background(@keypair)

    describe 'isUnlocked', ->
      it 'responds true if unlocked', ->
        spyOn(@keypair, 'isUnlocked').andReturn(true)
        expect(@background.isUnlocked()).toBe(true)

      it 'responds false if locked', ->
        spyOn(@keypair, 'isUnlocked').andReturn(false)
        expect(@background.isUnlocked()).toBe(false)

    describe 'unlock', ->
      describe 'success', ->
        beforeEach ->
          @deferred = jQuery.Deferred()
          spyOn(@background.app, 'authenticate').andReturn(@deferred)
          spyOn(@keypair, 'unlock').andReturn(true)
          spyOn(@keypair, 'isUnlocked').andReturn(true)

        it 'returns true', ->
          expect(@background.unlock()).toBe(true)

        it 'authenticates app', ->
          @background.unlock()
          expect(@background.app.authenticate).toHaveBeenCalled()

        it 'fetches items', ->
          spyOn(@background.items, 'fetch')
          @background.unlock()
          @deferred.resolve()
          expect(@background.items.fetch).toHaveBeenCalled()

      describe 'failure', ->
        beforeEach ->
          spyOn(@background.app, 'authenticate')
          spyOn(@keypair, 'unlock').andReturn(false)
          spyOn(@keypair, 'isUnlocked').andReturn(false)

        it 'returns false', ->
          expect(@background.unlock()).toBe(false)

        it 'does not authenticate app', ->
          expect(@background.app.authenticate).not.toHaveBeenCalled()

    describe 'save', ->
      beforeEach ->
        @items = {create: jasmine.createSpy('create')}
        @background.items = @items
        @background.submit({username:'chrome', password:'secr3t'}, @sender)

      it 'creates an item', ->
        @background.save(@sender.tab.id, {name: 'Test'}, @sender)

        expect(@items.create).toHaveBeenCalledWith
          name: 'Test'
          host: 'example.com'
          data:
            username: 'chrome'
            password: 'secr3t'

    describe 'autofill', ->
      describe 'when an item exists for the domain', ->
        beforeEach ->
          @data = {username: 'bkeepers', password: 'testing'}
          @item =
            data: => @data

          spyOn(@background.items, 'forHost').andReturn(@item)

        it 'returns item data', ->
          expect(@background.autofill(@sender)).toBe(@data)
          expect(@background.items.forHost).toHaveBeenCalledWith('example.com')

      describe 'when an item does not exist', ->
        beforeEach ->
          spyOn(@background.items, 'forHost').andReturn(undefined)

        it 'returns undefined', ->
          expect(@background.autofill(@sender)).toBe(undefined)

