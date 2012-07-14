class VaultsController < ApplicationController
  def index
    render :json => Vault.all.map { |vault| {
      :id   => vault.id.to_s,
      :name => vault.name,
      :key  => vault.key
    }}
  end

  def create
    @vault = Vault.create!(
      :name => params[:name],
      :key  => params[:key]
    )
    render :json => @vault
  end
end