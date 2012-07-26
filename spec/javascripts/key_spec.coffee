require '/assets/lib/aes.js'
require '/assets/models/key.js'

describe 'Vault', ->
  describe 'unlock', ->
    beforeEach ->
      @key = new Key(Key.create('password'))

    it 'is false if locked', ->
      expect(@key.isUnlocked()).toBe(false)

    it 'is true after unlocking', ->
      expect(@key.unlock('password')).toBe(true)

    it 'is false after giving wrong password', ->
      @key.unlock('wrong password')
      expect(@key.isUnlocked()).toBe(false)
