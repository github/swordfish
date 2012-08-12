class ItemsController < ApplicationController
  def index
    render :json => ItemListPresenter.new(current_user)
  end

  def create
    item = Item.create!(
      :title          => params[:title],
      :encrypted_data => params[:encrypted_data]
    )
    share = item.share_with(current_user, params[:key])
    render :json => ItemPresenter.new(item, share), :status => :created
  end
end