class VaultsController < ApplicationController
  def index
    render :json => Vault.all.map {|vault| VaultPresenter.new(vault) }
  end

  def create
    @vault = Vault.create!(
      :name => params[:name],
      :key  => params[:key]
    )
    render :json => VaultPresenter.new(@vault)
  end
end