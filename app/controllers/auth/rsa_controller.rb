class Auth::RsaController < ApplicationController
  skip_before_filter :sign_in_required

  def create
    options = {:public_key => request.raw_post}
    user = User.first(options) || User.create!(options)
    challenge = RsaChallenge::Request.new(user)
    render :json => challenge.value
  end

  def update
    challenge = RsaChallenge::Response.new(request.raw_post)
    if challenge.valid?
      self.current_user = User.get(challenge.user_id)
      head 200
    else
      head 401
    end
  end
end