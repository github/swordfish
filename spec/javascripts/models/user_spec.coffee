#= require models

describe 'User', ->
  describe 'publicKey', ->
    it 'initializes the key', ->
      user = new User(public_key: readFixtures('pub.pem.txt'))
      expect(user.publicKey().encrypt).toBeTruthy()
