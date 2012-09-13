require '/assets/chromemock.js'
require '/assets/chrome/lib.js'
require '/assets/chrome/infobar.js'

describe 'Infobar.Save', ->
  beforeEach ->
    @deferred = jQuery.Deferred()
    @extension = {save: jasmine.createSpy('save').andReturn(@deferred)}
    @infobar = {id: '2', extension: @extension, dismiss: jasmine.createSpy('dismiss')}
    @view = new Infobar.Save(infobar: @infobar)
    @view.render()

  describe 'submit', ->
    it 'sends unlock to extension', ->
      @view.$('input[type=text]').val('Test')
      @view.submit()
      expect(@extension.save).toHaveBeenCalledWith('2', {title: 'Test'})

    it 'returns false', ->
      expect(@view.submit()).toBe(false)

    describe 'on success', ->
      beforeEach ->
        @deferred.resolve()
        @view.submit()

      it 'dismisses infobar', ->
        expect(@infobar.dismiss).toHaveBeenCalled()
