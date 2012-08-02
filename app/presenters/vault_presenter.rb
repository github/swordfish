class VaultPresenter
  def initialize(vault)
    @vault = vault
  end

  def as_json(options = nil)
    {
      'id'    => @vault.id.to_s,
      'name'  => @vault.name,
      'key'   => @vault.key,
      'items_id' => @vault.items_id,
      'items_key' => @vault.items_key
    }
  end
end
