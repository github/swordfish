class ApplicationController < ActionController::Base
  before_filter :sign_in_required

  rescue_from Toy::NotFound, :with => :not_found

private

  def not_found(exception = nil)
    head :not_found
  end

  def sign_in_required
    head 401 unless signed_in?
  end

  def current_user
    @current_user ||= current_user_from_challenge
  end

  def current_user_from_challenge
    if request.headers['X-Challenge']
      challenge = RsaChallenge::Response.new(request.headers['X-Challenge'])
      User.get!(challenge.user_id) if challenge.valid?
    end
  end

  def signed_in?
    !!current_user
  end

  def current_team
    @team ||= Team.get!(params[:team_id])
  end

  def ensure_team_admin
    @membership = current_team.membership(current_user)
  end
end
