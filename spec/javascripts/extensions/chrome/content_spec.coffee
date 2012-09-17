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
    beforeEach ->
      @form.find('button').trigger('click')

    it 'sends message with form variables', ->
      params = {username:'bkeepers', password: 'testing'}
      expect(@content.extension.send).toHaveBeenCalledWith('submit', params)

  describe 'keydown', ->
    beforeEach ->
      spyOn(@content, 'autofill')
      @form.simulate( "keydown", {keyCode: @content.keyCode, metaKey: true} );

    it 'sends autofill to extension', ->
      expect(@content.extension.send).toHaveBeenCalledWith('autofill')

    it 'calls autofill on success', ->
      @deferred.resolve('foobar')
      expect(@content.autofill).toHaveBeenCalledWith('foobar')
