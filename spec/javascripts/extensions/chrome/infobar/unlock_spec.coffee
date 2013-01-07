require '/assets/chromemock.js'
require '/assets/chrome/lib.js'
require '/assets/chrome/infobar.js'

describe 'Infobar.Unlock', ->
  beforeEach ->
    @deferred = jQuery.Deferred()
    @extension = {send: jasmine.createSpy('send').andReturn(@deferred)}
    @infobar = {extension: @extension, save: jasmine.createSpy('save')}
    @view = new Infobar.Unlock(infobar: @infobar)
    @view.render()

  describe 'submit', ->
    it 'sends unlock to extension', ->
      @view.$('input[type=password]').val('passphrase')
      @view.submit()
      expect(@extension.send).toHaveBeenCalledWith('unlock', 'passphrase')

    it 'returns false', ->
      expect(@view.submit()).toBe(false)

    describe 'on success', ->
      beforeEach ->
        @deferred.resolve()
        @view.submit()

      it 'calls save on infobar', ->
        expect(@infobar.save).toHaveBeenCalled()

    describe 'on failure', ->
      beforeEach ->
        @deferred.reject()
        @view.submit()

      it 'shows error', ->
        expect(@view.$('.error').text()).toEqual('Incorrect passphrase!')
