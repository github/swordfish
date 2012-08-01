require '/assets/lib/aes.js'
require '/assets/models/key.js'

describe 'Vault', ->
  beforeEach ->
    @key = new Key(Key.create('password'))

  describe 'unlock', ->
    it 'is false if locked', ->
      expect(@key.isUnlocked()).toBe(false)

    it 'is true after unlocking', ->
      expect(@key.unlock('password')).toBe(true)

    it 'is false after giving wrong password', ->
      @key.unlock('wrong password')
      expect(@key.isUnlocked()).toBe(false)

  describe 'encrypt/decrypt', ->
    beforeEach ->
      @key.unlock('password')

    it 'encrypts the key with the key', ->
      expect(@key.decrypt(@key.encrypt('topsecret'))).toEqual('topsecret')