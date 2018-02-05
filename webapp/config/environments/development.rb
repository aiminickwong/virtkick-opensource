class NoCompression
  def compress(string)
    # do nothing
    string
  end
end

Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.action_view.raise_on_missing_translations = true

  if ENV['INLINE']
    config.active_job.queue_adapter = :inline
  end
  config.assets.digest = false
  config.assets.compress = true
  config.assets.js_compressor = NoCompression.new
  config.assets.css_compressor = NoCompression.new
  config.assets.debug = true
  config.assets.raise_runtime_errors = true
end
