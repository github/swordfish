require '/assets/application.js'

describe 'Invite.Collection', ->
  beforeEach ->
    @team = {url: -> '/teams/1'}
    @collection = new Invite.Collection([], team: @team)

  describe 'url', ->
    it 'uses the team id', ->
      expect(@collection.url).toEqual('/teams/1/invites')