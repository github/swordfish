class TeamListPresenter
  def initialize(user)
    @user = user
  end

  def memberships
    @memberships ||= @user.memberships.index_by(&:team_id)
  end

  def teams
    @teams ||= Team.where(:id => memberships.keys).all
  end

  def as_json(options = nil)
    teams.map { |team|
      TeamPresenter.new(team, memberships[team.id])
    }.as_json(options)
  end
end