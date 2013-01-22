class ItemListPresenter
  def initialize(user)
    @user = user
  end

  def shares
    @shares ||= Share.where(:user_id => @user.id).index_by(&:item_id)
  end

  def items
    @items ||= Item.where(:id => shares.keys)
  end

  def as_json(options = nil)
    items.map {|item| ItemPresenter.new(item, shares[item.id]) }.as_json(options)
  end
end