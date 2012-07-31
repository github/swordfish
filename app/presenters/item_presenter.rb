class ItemPresenter
  def initialize(item)
    @item = item
  end

  def as_json(options = {})
    {
      'id'       => @item.id.to_s,
      'vault_id' => @item.vault_id.to_s,
      'hostname' => @item.hostname,
      'username' => @item.username,
    }
  end
end
