require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module VirtkickWebapp
  class Application < Rails::Application
    # config.time_zone = 'Pacific Time (US & Canada)'
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true

    config.autoload_paths += %W(
      #{config.root}/app/lib
    )

    config.active_record.raise_in_transactional_callbacks = true

    config.active_support.deprecation = :notify
    config.log_level = :warn
    config.log_formatter = ::Logger::Formatter.new
    config.autoflush_log = true

    config.serve_static_assets = true

		config.assets.digest = true
    config.assets.enabled = true
    # config.assets.js_compressor = :uglifier
    config.assets.compile = true
    config.assets.version = '1.0'
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.precompile += %w(.svg .eot .woff .ttf)
    config.stylesheets_dir = '/css'

    config.active_job.queue_adapter = :delayed_job

    config.x.api_url = 'http://0.0.0.0:8000/1'

    # uncomment to debug compiled builds
    config.requirejs.build_config['optimize'] = 'none'
    config.requirejs.build_config['wrapShim'] = 'true'



  end
end
