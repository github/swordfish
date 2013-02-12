class ItemPresenter
  def initialize(item, share)
    @item = item
    @share = share
  end

  def as_json(options = {})
    {
      'id'             => @item.id.to_s,
      'title'          => @item.title,
      'encrypted_data' => @item.encrypted_data,
      'key'            => share,
      'shares'         => @item.shares.map {|s| SharePresenter.for(s).as_json }
    }
  end

  def share
    if @share.owner_type == 'Team'
      {
        "team_id" => @share.owner_id,
        "key" => @share.key
      }
    else
      @share.key
    end
  end
end
