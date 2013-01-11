class InvitePresenter
  def initialize(invite)
    @invite = invite
  end

  def as_json(options = {})
    {
      'id'    => @invite.id.to_s,
      'email' => @invite.email
    }
  end
end
