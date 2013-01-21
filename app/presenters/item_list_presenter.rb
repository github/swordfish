class ItemListPresenter
  def initialize(user)
    @user = user
  end

  def shares
    @shares ||= Share.all(:conditions => { :user_id => @user.id }).index_by(&:item_id)
  end

  def items
    @items ||= Item.all(:conditions => { :id => shares.keys })
  end

  def as_json(options = nil)
    items.map {|item| ItemPresenter.new(item, item.share) }.as_json(options)
  end
end