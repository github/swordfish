require '/assets/chromemock.js'
require '/assets/chrome/content.js'
require '/assets/support/jquery.simulate.js'

describe 'Chrome content script', ->

  beforeEach ->
    @form = $(
      """
        <form>
          <input name="username" value="bkeepers">
          <input type="password" name="password" value="testing">
          <button type="submit">Sign In</button>
        </form>
      """
    )

    # prevent form from actually submitting
    @form.on 'submit', (e) -> e.preventDefault()

    $('#test').append(@form)

    @content = new Content(@form[0])
    @deferred = jQuery.Deferred()
    spyOn(@content.extension, 'send').andReturn(@deferred)

  describe 'on form submit', ->
    it 'sends message with form variables', ->
      @form.find('button').trigger('click')
      params = {username:'bkeepers', password: 'testing'}
      expect(@content.extension.send).toHaveBeenCalledWith('submit', params)

    describe 'with data-swordfish-disable attribute', ->
      beforeEach ->
        @form.attr('data-swordfish-disable', true)

      it 'does not sent message', ->
        @form.find('button').trigger('click')
        expect(@content.extension.send).not.toHaveBeenCalled()

    describe 'with data-swordfish-disable attribute on parent element', ->
      beforeEach ->
        @form.wrap('<div></div>').parent().attr('data-swordfish-disable', true)

      it 'does not sent message', ->
        @form.find('button').trigger('click')
        expect(@content.extension.send).not.toHaveBeenCalled()

  describe 'keydown', ->
    beforeEach ->
      spyOn(@content, 'autofill')
      @form.simulate( "keydown", {keyCode: @content.keyCode, metaKey: true} );

    it 'sends autofill to extension', ->
      expect(@content.extension.send).toHaveBeenCalledWith('autofill')

    it 'calls autofill on success', ->
      @deferred.resolve('foobar')
      expect(@content.autofill).toHaveBeenCalledWith('foobar')
