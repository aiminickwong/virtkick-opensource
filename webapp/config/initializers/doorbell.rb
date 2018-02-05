# https://doorbell.io - gather in-app feedback.
# Go to "Installation instructions" in settings and grab a few fields:
# - App Key - Take from the snippet hash key "appKey".
# - App ID - Take it from the URL, e.g. it's 123 for https://doorbell.io/applications/123/setup#install
# - Secret - Below the snippet choose Ruby language in the dropdown. "jsonp_secret" field is what you're looking for.

if ENV['DOORBELL_APP_KEY'] and ENV['DOORBELL_APP_ID']
  Rails.application.configure do
    config.x.doorbell.app_key = ENV['DOORBELL_APP_KEY']
    config.x.doorbell.app_id = ENV['DOORBELL_APP_ID']
    config.x.doorbell.secret = ENV['DOORBELL_SECRET']
  end
end
