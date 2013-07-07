class InvitePresenter
  def initialize(invite)
    @invite = invite
  end

  def as_json(options = {})
    hash = {
      'id'    => @invite.id.to_s,
      'email' => @invite.email
    }

    if @invite.accepted?
      hash.update(
        'user' => UserPresenter.new(@invite.user).as_json
      )
    end

    hash
  end
end
