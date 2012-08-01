class VaultPresenter
  def initialize(vault)
    @vault = vault
  end

  def as_json(options = nil)
    {
      'id'   => @vault.id.to_s,
      'name' => @vault.name,
      'key'  => @vault.key,
    }
  end
end
