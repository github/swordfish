class KeysController < ApplicationController
  skip_before_filter :key_required

  def new
  end

  def create
    current_user.public_key = request.raw_post
    current_user.save
    head :created
  end
end