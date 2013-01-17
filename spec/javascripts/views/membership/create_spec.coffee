require '/assets/application.js'
require '/assets/ui.js'

describe 'Membership.Views.Create', ->
  beforeEach ->
    @team = {invite: jasmine.createSpy('invite')}
    @event = {preventDefault: jasmine.createSpy('preventDefault')}
    @email = 'bkeepers@github.com'

    @view = new Membership.Views.New(model: @team)

    @view.$el.append """
      <input type="email" value="#{@email}">
    """

  describe 'submit', ->
    beforeEach -> @view.submit(@event)

    it 'cancels the normal form submission', ->
      expect(@event.preventDefault).toHaveBeenCalled()

    it 'creates an invite', ->
      expect(@team.invite).toHaveBeenCalledWith(@email)
