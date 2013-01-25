#= require models

describe 'Invite', ->
  beforeEach ->
    spyOn jQuery, 'ajax'

  describe 'accept', ->
    it 'makes an ajax request', ->
      Invite.accept(123)
      expect(jQuery.ajax).toHaveBeenCalledWith(
        url: '/invites/123'
      )

  describe 'fulfill', ->
    beforeEach ->
      @invite = new Invite(token: 'token', user: {})
      @key = {encrypt: jasmine.createSpy('encrypt').andReturn('encrypted')}
      spyOn(@invite.user, 'publicKey').andReturn(@key)
      @invite.fulfill('key')

    it 'makes an ajax request', ->
      expect(jQuery.ajax).toHaveBeenCalledWith
        url: '/invites/token/fulfill',
        data: {key: 'encrypted'}

    it 'encrypts key', ->
      expect(@key.encrypt).toHaveBeenCalledWith('key')

  describe 'constructor', ->
    it 'sets up user', ->
      invite = new Invite(user: {public_key: 'foobar'})
      expect(invite.user).toBeTruthy()
      expect(invite.user.get('public_key')).toEqual('foobar')
