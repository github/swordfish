class ItemPresenter
  def initialize(item, share)
    @item = item
    @share = share
  end

  def as_json(options = {})
    {
      'id'             => @item.id.to_s,
      'title'          => @item.title,
      'host'           => @item.host,
      'encrypted_data' => @item.encrypted_data,
      'key'            => @share.key
    }
  end
end
