window.chrome or= {}
chrome.extension =
  sendMessage: jasmine.createSpy('sendMessage')

require '/assets/chrome/content.js'

describe 'Chrome content script', ->

  describe 'on form submit', ->
    beforeEach ->
      test = document.getElementById('test')
      test.innerHTML =
        """
          <form>
            <input name="username" value="bkeepers">
            <input type="password" name="password" value="testing">
            <input type="submit" name="button" value="Sign In">
          </form>
        """

      # prevent form from submitting
      test.children[0].addEventListener 'submit', (e) ->
        e.preventDefault()

      button = test.children[0].button

      event = document.createEvent("MouseEvents");
      event.initMouseEvent("click", true, true, window,
        0, 0, 0, 0, 0, false, false, false, false, 0, null)

      button.dispatchEvent(event)

    it 'sends message with form variables', ->
      expected = {submit: {username:'bkeepers', password: 'testing'}}
      expect(chrome.extension.sendMessage).toHaveBeenCalledWith(expected)