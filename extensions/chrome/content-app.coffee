# Content script when on the Swordfish site

# Send private key to the extension
chrome.extension.sendMessage key: [localStorage['privateKey']]