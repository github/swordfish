class ApplicationMailer < ActionMailer::Base
  append_view_path Rails.root.join('app', 'mailers')
  default_url_options.update :host => ENV['APP_HOST']

private

  def subject(text)
    "[Swordfish] #{text}"
  end
end
