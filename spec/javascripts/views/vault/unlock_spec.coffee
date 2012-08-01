require '/assets/application.js'

describe 'Vault.Views.Unlock', ->
  beforeEach ->
    @key =
      isUnlocked: -> false
      unlock: -> true

    @complete = jasmine.createSpy('complete')
    @model = {key: @key, toJSON: -> {}}
    @controller = new Vault.Views.Unlock(model: @model, complete: @complete)

  describe 'unlock', ->
    describe 'with the correct password', ->
      it 'calls complete callback', ->
        @controller.unlock()
        expect(@controller.complete).toHaveBeenCalled()

      it 'returns false', ->
        expect(@controller.unlock()).toBe(false)

    describe 'with an incorrect password', ->
      beforeEach ->
        @key.unlock = -> false

      it 'does not call complete callback', ->
        @controller.unlock()
        expect(@controller.complete).not.toHaveBeenCalled()

      it 'shows error', ->
        @controller.unlock()
        expect(@controller.$el.hasClass('error')).toBe(true)

      it 'returns false', ->
        expect(@controller.unlock()).toBe(false)
