class Auth::RsaController < ApplicationController
  skip_before_filter :sign_in_required, :key_required

  def show
    user = User.first(:public_key => params[:public_key])
    challenge = RsaChallenge::Request.new(user)
    render :json => challenge.value
  end

  def create
    challenge = RsaChallenge::Response.new(params[:challenge])
    if challenge.valid?
      self.current_user = User.get(challenge.user_id)
      head 200
    else
      head 401
    end
  end
end