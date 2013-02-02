class SharePresenter

  class UserSharePresenter < SharePresenter
    def as_json(options = nil)
      {
        'user_id' => @share.owner_id,
        'name' => "User #{@share.owner_id}"
      }
    end
  end

  class TeamSharePresenter < SharePresenter
    def as_json(options = nil)
      {
        'team_id' => @share.owner_id,
        'name' => @share.owner.name
      }
    end
  end

  def self.for(share)
    presenter = const_get("#{share.owner_type}SharePresenter")
    presenter.new(share)
  end

  def initialize(share)
    @share = share
  end

end
