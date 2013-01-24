class ItemsController < ApplicationController
  def index
    render :json => ItemListPresenter.new(current_user)
  end

  def create
    item = Item.create!(item_params)
    share = item.share_with(current_user, params[:key])
    render :json => ItemPresenter.new(item, share), :status => :created
  end

  def update
    item = Item.find(params[:id])
    share = item.share_for(current_user)
    item.update_attributes(item_params)
    render :json => ItemPresenter.new(item, share)
  end

private

  def item_params
    params.permit(:title, :encrypted_data)
  end
end
