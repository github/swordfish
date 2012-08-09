class VaultsController < ApplicationController
  def index
    render :json => current_user.vaults.map {|vault| VaultPresenter.new(vault) }
  end

  def create
    vault = Vault.create!(
      :name => params[:name],
      :key  => params[:key]
    )
    current_user.add_vault vault
    render :json => VaultPresenter.new(vault)
  end

  def update
    @vault = Vault.find(params[:id])
    @vault.items_id  = params[:items_id]
    @vault.items_key = params[:items_key]
    @vault.save
    render :json => VaultPresenter.new(@vault)
  end
end