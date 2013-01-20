#= require models

describe 'Invite', ->
  beforeEach ->
    spyOn jQuery, 'ajax'

  describe 'accept', ->
    it 'makes an ajax request', ->
      Invite.accept(123)
      expect(jQuery.ajax).toHaveBeenCalledWith(
        url: '/invite/123'
      )
