class TeamListPresenter
  def initialize(user)
    @user = user
  end

  def memberships
    @memberships ||= Membership.all(:user_id => @user.id).index_by(&:team_id)
  end

  def teams
    @teams ||= Team.all(:id => memberships.keys)
  end

  def as_json(options = nil)
    teams.map {|team| TeamPresenter.new(team, memberships[team.id]) }.as_json(options)
  end
end