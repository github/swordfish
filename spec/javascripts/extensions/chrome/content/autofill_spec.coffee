require '/assets/chromemock.js'
require '/assets/chrome/content.js'

describe 'Autofill', ->
  beforeEach ->
    @form = $(
      """
        <form>
          <input name="username">
          <input name="password">
        </form>
      """
    )
    @form.appendTo('#test')

    # prevent form from actually submitting
    @form.on 'submit', (e) -> e.preventDefault()

    @params =
      username: 'bkeepers',
      password: 'swrdfsh'

    @autofill = new Autofill(@params, $('#test')[0])

  describe 'find', ->
    it 'returns form with matching elements', ->
      expect(@autofill.find()[0]).toBe(@form[0])

    it 'returns undefined if none found', ->
      @autofill.params.other = 'missing field'
      expect(@autofill.find()[0]).toBe(undefined)

  describe 'submit', ->
    it 'fills in form values', ->
      @autofill.submit()
      expect(@form.find('[name=username]').val()).toEqual(@params.username)
      expect(@form.find('[name=password]').val()).toEqual(@params.password)

    it 'submits form', ->
      spy = jasmine.createSpy('callback')
      @form.on 'submit', spy
      @autofill.submit()
      expect(spy).toHaveBeenCalled()

    it 'adds data-swordfish-disable attribute', ->
      @autofill.submit()
      expect(@form.attr('data-swordfish-disable')).toBeTruthy()