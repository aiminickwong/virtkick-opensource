Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.action_mailer.raise_delivery_errors = true # Will run in a background job, so users won't get a 500, but we will be notified by Bugsnag
  config.active_record.dump_schema_after_migration = false
end
