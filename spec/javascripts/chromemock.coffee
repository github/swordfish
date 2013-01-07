window.chrome or= {}
chrome.extension =
  sendMessage: jasmine.createSpy('addListener')
  onMessage:
    addListener: jasmine.createSpy('addListener')
