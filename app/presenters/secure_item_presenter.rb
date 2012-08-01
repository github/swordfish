class SecureItemPresenter < ItemPresenter
  def as_json(options = nil)
    super.update({
      'password' => @item.password
    })
  end
end