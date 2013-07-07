#= require models

describe 'Team', ->
  beforeEach ->
    @keypair =
      encrypt: jasmine.createSpy('encrypt').andReturn('encrypted')
      decrypt: jasmine.createSpy('decrypt').andReturn('decrypted')

    Backbone.Model.prototype.app = {keypair: @keypair}
    spyOn(jQuery, 'ajax')

  describe 'initialize', ->
    it 'generates a key', ->
      spyOn(ItemKey, 'generate').andReturn('generated key')

      team = new Team()
      expect(team.get('key')).toEqual('encrypted')
      expect(ItemKey.generate).toHaveBeenCalled()
      expect(@keypair.encrypt).toHaveBeenCalledWith('generated key')

    it 'does not override existing key', ->
      team = new Team({key: 'existing key'})
      expect(team.get('key')).toEqual('existing key')

  describe 'invite', ->
    describe 'when the user does not exist', ->
      it 'creates an invite', ->
        @team = new Team()
        spyOn @team.invites, 'create'
        @team.invite('bkeepers@github.com')
        expect(@team.invites.create).toHaveBeenCalledWith({email: 'bkeepers@github.com'}, {wait: true})
