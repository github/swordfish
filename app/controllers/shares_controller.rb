class SharesController < ApplicationController
  before_filter :ensure_item_permission

  def create
    item = Item.get!(params[:item_id])
    team = Team.get!(params[:team_id])

    item.share_with(team, params[:key])
    head :created
  end

private

  def ensure_item_permission
    @item = Item.get!(params[:item_id])
    @share = @item.share_for(current_user)
  end
end
