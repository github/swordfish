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
    item = Item.find_by_id(params[:id])
    share = Share.where(:user_id => current_user.id).where(:item_id => item.id).first
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