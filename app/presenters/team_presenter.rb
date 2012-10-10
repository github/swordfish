class TeamPresenter
  def initialize(team, membership)
    @team = team
    @membership = membership
  end

  def as_json(options = {})
    {
      'id'   => @team.id.to_s,
      'name' => @team.name,
      'key'  => @membership.key
    }
  end
end
