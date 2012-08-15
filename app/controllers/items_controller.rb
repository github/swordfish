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
    item = Item.get(params[:id])
    share = Share.first(:user_id => current_user.id, :item_id => item.id)
    if share
      item.update_attributes(item_params)
      render :json => ItemPresenter.new(item, share)
    else
      head 404
    end
  end

private

  def item_params
    params.slice(:title, :encrypted_data)
  end
end