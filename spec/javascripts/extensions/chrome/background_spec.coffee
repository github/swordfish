window.chrome or= {}
chrome.extension =
  onMessage:
    addListener: jasmine.createSpy('addListener')

require '/assets/chrome/background.js'

describe 'Chrome background script', ->
  beforeEach ->
    Keypair.localStorage = @local = {}
    @background = new Background

  describe 'key', ->
    @pem = 'key'

    it 'saves key in localStorage', ->
      @background.key(@pem)
      expect(@local['privateKey']).toEqual(@pem)

    it 'does not override existing key', ->
      @background.key('existing')
      @background.key('changed')
      expect(@local['privateKeyx']).toEqual('existing')
