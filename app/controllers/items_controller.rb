class ItemsController < ApplicationController
  def index
    @vault = Vault.get(params[:vault_id])
    @items = Item.all(:vault_id => @vault.id)
    render :json => @items.map {|i| ItemPresenter.new(i) }
  end

  def create
    @vault = Vault.get(params[:vault_id])
    @item = Item.create!(
      :hostname => params[:hostname],
      :username => params[:username],
      :password => params[:password],
      :vault_id => @vault.id
    )
    render :json => ItemPresenter.new(@item)
  end
end