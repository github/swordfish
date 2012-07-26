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

  class ItemPresenter
    def initialize(item)
      @item = item
    end

    def as_json(options = {})
      @item.serializable_hash.merge(
        'id'       => @item.id.to_s,
        'vault_id' => @item.vault_id.to_s
      )
    end
  end
end